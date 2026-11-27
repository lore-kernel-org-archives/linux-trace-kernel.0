Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779355;
	b=qFsr2njA980A+clqKh6L0oAjQ3X3pO1PnUrJcz2Wposp+CPFyLhZP9h6ColXKYhOOMJK
	 jGlDaeFV2FGwGOP5MnrDXzVJqHjmP4ZkrNWWCLU/V3NFEnTTt7YjUG3qbfeyv9bjuOYQo
	 Wv0AaoSOIwaXXfXgKkThtIWW4G6nYHoTDGoREJzYCLvkcuvBBPfC4/tv24IcgtjqSfmEq
	 BW6JYVEgRznqeHGNXnfCTwbQSIj6lDPd7Cg6IPsey1A8JKOynSFuDJtKPpcJ1Z3Zm99Tq
	 BH8GthcQBlPVuew7GXOIEw7FT/vvWCpsVq3r+pvoVlV4rs1aNk/Em0tZm1XGrXnqWOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779355;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d3+1qCV+TR3mdhJOLlYGsFvO/T7OVgR7lWpVkeYS7CU=;
	b=h2uaMcX8aqzNWGAHm3OiZX3O1WJJGpa0rbxQyvquC4SORbFytq4mzKDHi7veUV0Ky/Zv
	 MCGc57wqFbnNAuntEWX1nZOYHkB0GVjTP+ZMfHOPm/TTQKaK6DOukq/QQSZ0DB3P2pDTR
	 ubN741sB0/vx/HujDATFkicYccAZ5zFvVHMrumRsgjgExjPT9yN1+fj6OTGSILylwAz/u
	 OkQejV9t1o6buHUycQqW6Lpjr2i0KDYGDDhjx/Hi7yZ2WY9UURXfqgnqLOZLNCKGSmggC
	 aZsQLdBY4UHMqPmpcAMIMNW+rY28vSSksp9sBM13vMvx4ohPkDXyvhdDSVR2mtGNZng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jAvfJMWI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F40606A31E;
	Fri, 27 Nov 2026 11:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35F40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jAvfJMWI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuGsWShTdQdbCVb3wi8gGg0V0SXEzYnr0s+NOHiH3D8pFjcKona9UJhrm5qzXDRJV6Lhix/inP/lQgJPzyfnIl+T16lZM1tUdB0HlB/ZeCgN1XqFFX9kPagYirIg/UupkryMv4asi9gpxBs0arXhmMLGwNXcrwcodeC0KLP2wTZ86Tm11nEYwafiRwZOFe7jkD1g25rBjsDgg5GdPgQJt0RlDo6Y0Ex7w5KUblLr2igkgM6azHb0eF6AfWaea9s2KOrMNrjsCyi1q7shySlv1QH3rQEe/bIyqDhoKJgGqI01YIYEH4zigtdfpUMN8CHibU22ib/ujFxZgxEEu95N8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3+1qCV+TR3mdhJOLlYGsFvO/T7OVgR7lWpVkeYS7CU=;
 b=Gwt2KRwoJNoAn9r0NZN0STEPuDehnFcdgdVGQ2An5ai4uqEVacMPeXMxcNgimQeOUZuhUeQ16RcYT70qSl3nsLy/kbrLjlqepr+Cgiyf90HLNAOuohCcGG5WeiVwHGaGmqaps/b9xzHU1EYACbsDPGfByG0po9j4V/t1TSsP+MeE+8QnMExHHqItXkeHuQw6ICcycj/VpJPyySEj0BbL2PaD5lXn66OD5dQLNlJTnacM73FnTSvyS1jZMOftfzNcQxIL+cUIsqp+6Zgokcl4UW5E+256FQgmPljdWfWe0/N4ivuX1HDHJUq/2K9SsKLObAYcwrBymTTyp3eYD2Yb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3+1qCV+TR3mdhJOLlYGsFvO/T7OVgR7lWpVkeYS7CU=;
 b=jAvfJMWI2dc2fBTCN0Ylyk8zOZdPe/vm78OoXZgs989Glra4FyOmvwkaBg2N4edksnMRXnrOchQTOF8ahHrhw+zIbgNt0sCZgBOyS/ILNuzRPqDnpPBkoX3N3meiJXF6nDJciI/9dmDdhlx4YHudgC+SdGqP7RA1MyzOqyxcvtH+CTlVejPeUMhCOkCVTF6GaDUOFkQuAYMe8uIZVEF0axDWZFRFQGYm3f7ILNCSejOwsR9mss5BsGkO/Fafwh2ijwbDb6Mastun86ETdCCj/JcwwhLgfGGP0KG67j3LZLY3bPMMc6ACqnJhMpVvF7Khlz4zExknBV3mZ1shKENecQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 11:35:51 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 11:35:51 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 0/4] rv: per-edge dwell-time statistics for per-cpu monitors
Date: Fri, 27 Nov 2026 12:36:05 +0100
Message-ID: <20261127113609.650286-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb28453-890a-4f5c-476a-08df4c7a96cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|11063799006|6133799003|261009223027099003|18002099003|260925021911599003|260925022911599003|260925021311599003|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261022075727099003|261021121427099003|261021123027099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0kzY64eUjL1kGd+dyU5QzL8FlQ04vRX3lFgjBJZdt68ust86iusn7rth8FiO5czJcpb16Dl0gnmW9qLr2mqoO95CztO+70ImbWlYgYppQsGAVzkqaLS2XyF7MmTgmMwzZNgd2UMJmF2cKhM9+hV+B4n9M3J53nGYv1vVS+F/BrPvEdVDJ50UPJz+CTrgz5EHwlgEx3CKpSaMscVeLxSOxUQ99Lztp2End/keFy4oWLgaZMTKyNv1fbS0PdojIU6/azhqqD603btagMGPslMGzeRnlZ70jxRZBi98PZq4u3cDvY1xaxH7fIACqh6/P8TGPFSgRnhetQjaA7zacJ+asQrST2MaojyY7Q24v3IEuY1Yr2ZmgvE4t771D2tF6ShQOAXcmPnO1AcFY/nEZl/MmkF4TjlMfmeqP5zx/VHtF/utvnklxRdBE+fl4m7xRppeSWolTNrVExEqBZiScSkNq0R1fY37rPD329pgwDF1vdTak4Z9wv4gtBhoiuZG8efWXj9vdyqFM8zD2NjGMeLL0Cj3jfACH6/beiBMABdtg0H204sfwlcZWxogv2+Wjj9Fyx6zxDJR96WDGxogJzT88hu3Pwx5Ijqvv3ijRvk1bavoruZlfE9RimkFVWcH/Usw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(11063799006)(6133799003)(261009223027099003)(18002099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261021123027099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbTm8RCjEmh8sc4QECjfG60j0/DjpPt0rws4YTQrOlHITSpMiJtTirAhFYEn?=
 =?us-ascii?Q?jWZhMvO9MeYcUOcEv8EPsVAq8uNC7NjXHkbpp9TIjOEEvab0zEz3b7TVSmAM?=
 =?us-ascii?Q?Rdze0vMXqALDELy0ae3/pBPO8uQeMnCugA2QE+djPdWrxsOy4TYAV1cEOYGp?=
 =?us-ascii?Q?071YB27AVYVX1LhlbRY0h3t/U8gv7xhYl/eooN/mpfSQtTd7VVseZVA12aKs?=
 =?us-ascii?Q?iqE+tdkOmljvq4QadM8GW4vUO6ZOa9Yg7k/LN/+/4C3DCGyg8IChHc3eGeh8?=
 =?us-ascii?Q?W3NB4OhhDqJOcwJyDmHFAQjD46oSVazUdH/DOP36WLwu3+0llbdU45lx+f05?=
 =?us-ascii?Q?mgY7hxd3lInJHRLFL8FdoDOtZOaMmNakAbfMJx2pP2+ioV4p87VispJM4ac8?=
 =?us-ascii?Q?cakdCsumUj9jXEbZ/hK1VqP+yChU8eMQSXjedk/0IvCXkPl7WNJa1JIuhL5f?=
 =?us-ascii?Q?y3lc9bIX6ClTfMCvQugZtYuHT78kxKxL7azhivhSg9voN4Q5vG7tcUUW+AKe?=
 =?us-ascii?Q?AmCqfOzo4eIGNOi3HwxMVQQB/2oifNoGD3cgzi8PJyFLNlF2cJt9QRWoLiwG?=
 =?us-ascii?Q?dOWCcdu0+lYYBtAlNRDef29ZW+WThziPY4bAVdfSYbBN5nT6VkzoHxqa62aP?=
 =?us-ascii?Q?tduTmd+woyIOZtEOGdnIsrb9UtPD2SAyUXDEnoivj1BG/TDXu4hB3OVQFxau?=
 =?us-ascii?Q?Y1talCRgSIcoWE3/tqdDxM37n87CCstZvZFqROwwR23hq2fb4hTowzZZWNup?=
 =?us-ascii?Q?lNiYR3J0ZW6YwdvPGVUI8tmnW4j4pOtOmWuUXQm47yXrAsgJveF+5M6CXlmF?=
 =?us-ascii?Q?WwWyxrRcW0bdxeGviaWvy+PBqWZOhaYJhmP+E7Vr2ne8SyPYlXdwiprKg2i4?=
 =?us-ascii?Q?rL8cFqSoUmlobZJsSANq02YyEpBMaUZ9zM0WR4in9fUvLEItdR/qgvWEwQOI?=
 =?us-ascii?Q?0vltLJHF8PqbuytOfBOabxIhTHoOw5O0VJ2WT9x0vl/NlKOaH2gVJEXF8Ntq?=
 =?us-ascii?Q?V3rzb6OMRLV9BTNWx6EJ7f8dDXEIjXFKYB+yPRqGiuYj3f0QVZ4kfpz/wVMw?=
 =?us-ascii?Q?Qgsn9jrxDc6D0cvZ2VCTTHUc4y0evDh+fsp9K0gYjsS9EoNV3g9mWbHHbrkX?=
 =?us-ascii?Q?24OsH6FcRDoGQ3B6nJSPUNcaFgasiZhOBNuRD9/hALc1lRRBNlgDvENiuu3/?=
 =?us-ascii?Q?eAv21Vnt32y7Jqr42K52WMc6tl3YBaOIoDauReAzUn5rSLQyj77nnbTE02fH?=
 =?us-ascii?Q?zR0M4X1QpX1UcYiUGFQMEHiZC9jh/YKz8n5q2gpMMcnc6kxDKT0dPfY1NnP3?=
 =?us-ascii?Q?XMDLJCyqFrj1S/b38isdVcHJVM9zYgrtaTF6OcDBzE/XvAoc+K0N7zwX6kiE?=
 =?us-ascii?Q?LADgxAcjHlGnAYCbQ/ei/vqr6FDJToIvdZsogv02WfT1oozJUISrOhgwJ9E7?=
 =?us-ascii?Q?Sy3V9HwacrJVmYCJaXhkkBaoa5fI3SJjvwulbZSl4n3UAyGJ1BDKwtuXpaWI?=
 =?us-ascii?Q?JYRgtGQaQ8uwsHDS6poa/lIYjLWGXxS3k3OQjiDzeqBIZwDmGgmGxZkZcDht?=
 =?us-ascii?Q?C+2We5x4eXpczclH0yJyiaCtJxlVMo4Orn1QYy6KLRVx53+yIH0EOL2gZoXu?=
 =?us-ascii?Q?ZpISAL0f269Vomf3fOQQnlFuaWcccS/e7JuAeoCT4qnh4TplzBaJNUlG1EVz?=
 =?us-ascii?Q?ZfZEr66ZE4kY8tESLJgbed1tKSnMz5OmxyK7Ie2WWEZx9QGcYkAhsnja2HeV?=
 =?us-ascii?Q?9o0MK10aCju3phVwhh5U28F0+BjRFz5EXEfx3kXphsFTmIIp7AV4g120slx7?=
X-MS-Exchange-AntiSpam-MessageData-1: nf14sgGR/OaoSqD5ZAbc3qPFxLezcfL+FNs=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb28453-890a-4f5c-476a-08df4c7a96cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:51.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcGv63UyewNyJfVjXrDNP5RFKovE5XK7ASsTZsKYtUAwpk3WFy8vk0eahrTgka1MeI18sY99cBxC1oJj7lQhIubKs28PZ8U/WIzg2dS66M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425

Hi Steven, Gabriele,

I am using the RV system for a downstream project called EVL (aka Xenomai4).
It is a small co-kernel system, small enough that I can model the whole
co-kernel with RV instead of just a fragment of it.

The patches in this series add a per-monitor "stats" file that exposes how
often an edge has been visited and the dwell time in the prior state for
per-cpu monitors.

This allows me to not only check if the model is correct but also to see if
all paths are exercised by my stress tooling and to decompose the latency of
the co-kernel's wakeup path.

I think that some of the upstream monitors like e.g. the sts monitor could also
profit from this.

As an example, here is the sts monitor on a StarFive VisionFive2 running a
PREEMPT_RT kernel with this series (isolcpus=2-3 nohz_full=2-3). While it
was enabled, hackbench (-g 4 -l 2000) ran on cpus 0-1, a SCHED_FIFO
stress-ng cyclic thread (1 ms period) ran on the isolated cpu3 for 40 s,
and cpu2 stayed idle. Only edges with a non-zero count are shown; all of
them are valid (column 4) and every undefined edge stayed at zero:

  # cat monitors/sched/sts/stats
  # cpu edge label valid count sum_ns max_ns
  0 0 can_sched:irq_disable 1 11367959 39357857250 3955250
  0 4 can_sched:schedule_entry 1 912841 1953227750 54500
  0 7 cant_sched:irq_enable 1 11367959 15829311500 44750
  0 8 cant_sched:irq_entry 1 64567 105061000 6500
  0 13 disable_to_switch:irq_enable 1 8637 24605500 14250
  0 14 disable_to_switch:irq_entry 1 170 263500 5500
  0 15 disable_to_switch:sched_switch 1 904204 3682090250 24000
  0 18 enable_to_exit:irq_disable 1 8488 16681750 3500
  0 19 enable_to_exit:irq_enable 1 8488 55429250 23750
  0 20 enable_to_exit:irq_entry 1 8324 13597750 5500
  0 23 enable_to_exit:schedule_exit 1 912841 1015160500 2750
  0 25 in_irq:irq_enable 1 170 1154000 15500
  0 26 in_irq:irq_entry 1 2 2500 1250
  0 30 scheduling:irq_disable 1 913011 1096248500 2250
  0 37 switching:irq_enable 1 904204 2809182000 13000
  [ cpus 1-2 omitted ]
  3 0 can_sched:irq_disable 1 308000 44282747500 1991893250
  3 4 can_sched:schedule_entry 1 77831 99574500 6000
  3 7 cant_sched:irq_enable 1 308000 781368250 25750
  3 8 cant_sched:irq_entry 1 48789 71474750 4750
  3 13 disable_to_switch:irq_enable 1 7 24000 9000
  3 14 disable_to_switch:irq_entry 1 21 26750 1500
  3 15 disable_to_switch:sched_switch 1 77824 179601750 10500
  3 18 enable_to_exit:irq_disable 1 147 266000 3250
  3 19 enable_to_exit:irq_enable 1 147 1193250 14000
  3 20 enable_to_exit:irq_entry 1 143 198250 1750
  3 23 enable_to_exit:schedule_exit 1 77831 78554500 4250
  3 25 in_irq:irq_enable 1 21 199500 11250
  3 30 scheduling:irq_disable 1 77852 89848000 2500
  3 37 switching:irq_enable 1 77824 130814500 7000

The sts model splits the schedule->switch path into separate states, so the
per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 the
prep phase (disable_to_switch, irqs off until the switch) tops out at 24.0us
and the switch itself (switching:irq_enable) at 13.0us, over 904k switches.
The counts also line up with the model, e.g. every irq_disable in can_sched
has a matching irq_enable in cant_sched (11367959 == 11367959) and every
switch in disable_to_switch leaves switching once (904204 == 904204).

The isolated cpu3 only runs the cyclic thread, 77824 switches in 40 s, and
its worst case is tighter (10.5us prep, 7.0us switch), while the idle
isolated cpu2 shows no transitions at all. So the same file also makes the
effect of cpu isolation visible per cpu.

The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor is
enabled, so existing setups are unaffected. When enabled, each accepted
transition adds one local_clock() and a few lock-free local64_t updates. With
the config off there is no code on the hot path at all.

I focused on per-cpu monitors as a first step. Per-task and per-object
monitors would have to aggregate entities that share a cpu, which is harder
to get right, so I left them out for now.

What is your opinion on this? Do you think this is worth getting upstreamed?

Thanks for taking a look,
Tobias

---

Changes since v4:
 - Keep da_monitor_start() as it is and add
   da_monitor_start_unaccounted() for the run-start path instead of
   passing the state word. Both share __da_monitor_start() (Gabriele).

Changes since v3:
 - Based on Gabriele's BTF fix for rv.h [1]. Thanks for this!
 - Stamp the initial state only when the monitor starts on entering it
   (da_handle_start_event()). da_handle_start_run_event() starts a
   monitor in a state the system has been in for an unknown time, so
   its first dwell was a bogus few nanoseconds (sashiko). Documented
   that this first transition is neither counted or timed.
 - Made da_state_t a typedef instead of a define (Gabriele).
 - Moved RV_EDGE_STAT to the end of the RV Kconfig (Gabriele).

[1] https://lore.kernel.org/r/20261123083709.62502-1-gmonaco@redhat.com

Changes since v2:
 - Resplit the series: one patch adds the facility, one wires it into the
   DA/HA layer and one adds the selftest. da_state_t is now defined before
   its first use (Gabriele).
 - Used rv_create_file() / rv_remove() with RV_MODE_READ and included
   "rv.h" rather than <linux/tracefs.h> (Gabriele). That makes rv.h
   reachable from a header every monitor pulls in, so patch 1 guards it
   against double inclusion first.
 - Replaced the pack/unpack macros with FIELD_GET() and FIELD_PREP()
   (Gabriele).
 - Dropped struct rv_this_edges in favour of a plain per-cpu array of
   struct rv_edge_stat, used through per_cpu_ptr() and sizeof().
 - Added DA_EDGE(), DA_EDGE_STATE() and DA_EDGE_EVENT() instead of open
   coding the state * EVENT_MAX + event arithmetic.
 - New "valid" column, from model_get_next_state() != INVALID_STATE, so a
   non-zero count on an edge the model does not define is visible instead
   of having to be inferred from the label. The selftest checks it too.
 - unlikely() on the first-sample check, and dropped the (unsigned int)
   casts from both da_state_of() variants.

Changes since v1:
 - Packed the state and its entry timestamp into one word, so one cmpxchg
   commits both and a nested IRQ can no longer charge a dwell to the
   wrong edge. Hope this approach is fine.
 - Moved the header to include/rv/edge_stat.h (Gabriele).
 - Implemented it all in the da_monitor layer so that rv.c is untouched
   and the file is created from da_monitor_init() (Gabriele). I did not
   create a matrix living in struct da_monitor though. I think that this
   would need a fixed upper bound as rv.h does not know how many states
   and events the monitor will have. But this would lead to a large array
   in any monitor including per-task monitors.
 - Used local64_try_cmpxchg(), bound the loop at
   MAX_DA_RETRY_RACING_EVENTS and warn now if it is hit (Gabriele).
 - Static per-cpu matrix instead of alloc_percpu() (sashiko).
 - depend on 64BIT, so GENERIC_ATOMIC64 is unreachable and the 32-bit
   NMI deadlock cannot happen at all (sashiko).
 - Reset and report for_each_possible_cpu(), and reset before the
   tracepoints are registered (sashiko).
 - stats file is 0440 now, and a failed create is propagated.
 - Columns are now count sum_ns max_ns.

Tobias Schaffner (4):
  rv: guard rv.h against double inclusion
  rv: add per-edge dwell-time statistics
  rv: collect per-edge dwell time for per-cpu DA/HA monitors
  selftests/verification: test per-edge dwell-time statistics

 .../trace/rv/runtime-verification.rst         |  30 +++
 include/linux/rv.h                            |   9 +-
 include/rv/da_monitor.h                       |  40 +++-
 include/rv/edge_stat.h                        | 214 ++++++++++++++++++
 include/rv/ha_monitor.h                       |   2 +-
 kernel/trace/rv/Kconfig                       |  12 +
 kernel/trace/rv/rv.h                          |   5 +
 tools/testing/selftests/verification/config   |   3 +
 .../verification/test.d/rv_edge_stats.tc      |  37 +++
 9 files changed, 343 insertions(+), 9 deletions(-)
 create mode 100644 include/rv/edge_stat.h
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
prerequisite-patch-id: 206f940ad5b807994984989e14eb713386bf8b59
-- 
2.53.0

