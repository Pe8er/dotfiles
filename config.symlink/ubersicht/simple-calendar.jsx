import { css } from "uebersicht"

const sundayFirstCalendar = 'cal -h && date "+|%-d"';
export const command = sundayFirstCalendar;
export const refreshFrequency = 3600000; // ms
export const className = `
	font-family: system, -apple-system, 'Helvetica Neue';
	text-shadow: 0 1px 2px black;
	font-weight: 300;
	color: #fff;
	bottom: 10px;
	left: 10px;
`;
const rect = '16px';
const baseFontSize = '9px';
const margin = '2px';

const parse = output => {
	const separated = output.split('|')
	const rows = separated[0].trim().split('\n')
	const today = separated[1].trim()
	return {
		headers: rows[0].split(' ').slice(0, 2),
			tableHeaderRow: rows[1].trim().split(' '),
			tableBodyRows: rows.slice(2).map(s => s.match(/.{3}|.{2}$/g)),
			today,
		}
}

//////////////// header ////////////////
// const headerCss = css`
// padding-left: 5px;
// font-size: ${baseFontSize} * 1.1em;
// margin-bottom: 10px;
// `
// const header = (month, year) => <h1 className={headerCss}>{month} <span>{year}</span></h1>

//////////////// table ////////////////
const tableCss = css`
	border-collapse: collapse;
	table-layout: fixed;
	font-size: ${baseFontSize};

	th {
		display: inline-block;
		width: ${rect};
		height: ${rect};
		text-align: center;
		font-size: ${baseFontSize};
	}
	th:not(:first-of-type) {
		margin-left: ${margin};
	}

	td {
		display: inline-block;
		width: ${rect};
		height: ${rect};
		text-align: center;
		line-height: ${rect};
	}
	td:not(:first-of-type) {
		margin-left: ${margin};
	}
`
const todayDecoCss = css`
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: #fff;
	opacity: 0.3;
	// border-radius: 50%;
`

const todayCss = css`
	position: relative;
	text-shadow: 1px 1px #555;
`

const table = (headers, bodies, today) => {
	return <table className={tableCss}>
		<thead>
			<tr>
				{ headers.map(s => <th>{s}</th>) }
			</tr>
		</thead>
		<tbody>
			{ bodies.map(row => 
				<tr>
					{ row.map(s=> {
						return s.trim() === today ? <td className={todayCss}><span className={todayDecoCss}/>{s}</td> : <td>{s}</td> 
					})}
				</tr>) 
			}
		</tbody>
	</table>
}

export const render = ({output, error}) => {
	const s = parse(output)
	return error ? <p>{error}</p> : (
		<div>
			{table(s.tableHeaderRow, s.tableBodyRows, s.today)}
		</div>
	);
}
