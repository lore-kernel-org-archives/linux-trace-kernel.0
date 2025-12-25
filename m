Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB0137C52;
	Thu, 25 Dec 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766649745; cv=fail; b=CQ4YY5H23xiv2zCnDzdpgT/sBFWAZ3YSNtzRFdkVLLkyWeY1XGk1wfXbeoNqwumh53MfBJXbXNFBnNgZFtYym6ye2wLwXYHW26N1wvXZO9RN3Vm1btGMsLfIugHu7g6trOqG9drGF8pi+8oVOUFPHe2cwddD4rEPT5ThLiP+chk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766649745; c=relaxed/simple;
	bh=5bJT1F5VJPRkvjj6clRzZkaFgSJT6770Th5j4DkmEK4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ETPxJxepxjQF2jVg45RKfxPq25slYToWtowiI4kDjWB+R6G+vnt14LfGq+yzKGq5OrBR4ub813Kl3uE3UBjT/KuXC25/TGvehV9pomtB4uy5mUl/KxRfbOmkePv1HX2aZ92j29OGrqqLBS98gUou86uAQO0ZzZ9LijCAT1FcT6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hclfRbw9zPSHn8/wpmg+kiJU0NutWvbFPoIFDLdeqTQAZgf4k8wp3tVFNMTsQg3uWuc+0y18QZOoGI20wVWCvFjkQbaOTEa2cB0ZrZm8WjnZYYjpwGHbjfFJJ6ULGpmhQraV+iAzZiPy2LzI7Nz/U2JV7hWhmt1C5Q1vgrqc+NqYu/SGvun1f4LYIxKNy3zqybFqXFMMTmtMfwT2EyHUBDMXOPRMU/M4iVK7/g9alqhw80rANt+aqe9VG07AuOyKHRuMky+vr1WdAWYk7BkQOsQiDiJOlSuNfwzNvKqpjrSN2nWpF9gdH2cNaNpRDxRfa5zAQy9iFglSNQD/anhh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N2SoM9KfR6WThghxCh1wPWZky5egrU4XciPgvfjbAw=;
 b=em9RhC+5pqVxwwPpz0G0vl3iySHyAMdj2RM4x16OK36ezhLZvanuRMk/Z6naMvOaCk3z6TVaTnCEtEt5JswbmLzRP2Yno3sOszBvizY0sNtl9Ck2ST8riV1KsojQKAaG/QI0ybc71CMSXy7dNWvhhIaFkRiG35XBEdeT5dK87e+1TviC605dzxJv40V+epCm95i6vZHVKCeYfqsE69dJ3ZqA375jjlIbK6VK1E0PJLw/1yPPX5qwcgPYeHJV74uT46V2LtPynX4aNFYH91Di1Y2HP+Iha68kIEjf6N5PQH6PXFGGSztCx7StboRRVNNIM4RcspeejdKqiTW0IrkUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB3540.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Thu, 25 Dec
 2025 08:02:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 08:02:20 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v2 PATCH 0/1] tracing: Add bitmask-list option for human-readable bitmask display
Date: Thu, 25 Dec 2025 03:02:15 -0500
Message-ID: <20251225080216.2196411-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:408:fb::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB3540:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2183f0-b52b-4bc7-55b8-08de438bedc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/4QJKWH7JlJMuONZM3+QA5CfYYd8KZ+F3WQkELCTkBMnOWoilADZM2GpPvo?=
 =?us-ascii?Q?l1W1l/5oAJkaNq8WbwbpaY7r38WVRVF77qMqDZBCYzSPUQCsvYVOEEg+Svg3?=
 =?us-ascii?Q?k/vtKhfKUva5VLcSTLga5/dTpuRU3ozbcels5KxR7K4RHvQPYhizUciH7X4k?=
 =?us-ascii?Q?ungKVaAnYjiuRcU58wFWsnci1EL/zqYxLL8qJIdh8bHiIh2WnLISD/y9/TDh?=
 =?us-ascii?Q?oRTClGP3R/OGIhuxaC2+iU7podWmLNfAX4DDJX89/FoQOwFoa76zwjwwSZdY?=
 =?us-ascii?Q?M8UKxllOlvycBYx7oXXRR6ZKGlFePlvVBR8BGyNkSGFiotGZ74OtrvYQIZAs?=
 =?us-ascii?Q?Hv2789vKmUZ2TzZW7WfpmpEhA5lIC+vdH9sEAczUlZFfCf0NP4tDL9L0eVb9?=
 =?us-ascii?Q?RvIJ2OKjVd7tDx/15Kr9Qfk3VvhnZetwj+fvCqQddU6tS9ayOswjwifVE78a?=
 =?us-ascii?Q?mPtTDVzea1AeEdFry1hjFqzwD9pzVM1sR1v7UX1oz8gDWR4tl59G4uhF4RCU?=
 =?us-ascii?Q?0zC51rUS3W+GLpOMV5niK0bBnBMTjWJtUxIZ8JbqrQTKSCTQaDzZQYDjIEku?=
 =?us-ascii?Q?Ewcvx/8tLD6XXrYybRyYnFzxV1YccPDU3uMZC2dVPBF13ZriF3pnMOq1A+DI?=
 =?us-ascii?Q?GRMov+5BB0zfm84DaCnp9/D1bQAXW9BMj1Vuqo+A5aIRhMFW77AqE85/Igl9?=
 =?us-ascii?Q?U7abK677LkACp8ZGSXAtDujS55/lD8nI5bVxizE139giSBrhY3iHkSXfNAQb?=
 =?us-ascii?Q?CCYpP9ejsPWwasREx4L58D/4n4tPJFZnhWiYaaIR9fXBGSqfd0ujyD0Ti4e0?=
 =?us-ascii?Q?i0b5EGALj/EqjuHde5Hw/JmuLbAasrKc+isuNtzKB3CfzlaC/9tIQRrHk8If?=
 =?us-ascii?Q?V4XJhhkX+LO+98BqLzo8nv7jN5QyoKrIat5Z6MbTWn0IG6v+uaRUDYUt0xu/?=
 =?us-ascii?Q?n+hRLvKHsGL/ih4Jex3JJyNzvnZ18oUmPeFffGZCLrfJWVCgzFFsb9wMfREA?=
 =?us-ascii?Q?xrmpAC/duAqxNK9cN8tXysAhQC1AJNqfXIn/DGtKWTFPmJbiyCjSZz0rOpbE?=
 =?us-ascii?Q?TMf3CZ8Y46XSWAQsAgnhHKKpTWZF0t0xHhKDainRWKcg39Ezrf+WwlBELY15?=
 =?us-ascii?Q?bcsaR5E0m9DUD1WLk8xzfgn5P2oM+Z4cDOx4deS2djYVecXVRHb1OrlGakuZ?=
 =?us-ascii?Q?6SYllnot5u9rgrV3eyLOd8bGgeOJ66Pp6IvbF4tXj+Gy/d3mQ3nilAN1mvma?=
 =?us-ascii?Q?7Vfk8R4mI0gnF+tDd2cKBQN5SsU0vzHSrcQ42EKapPvfOZCWa06YFZuJzIR9?=
 =?us-ascii?Q?tj6OsWwzYH84/A9/Df3tGC7ae5RoEVhVSYy730CHuANSILiRQvpxG1QCAi4U?=
 =?us-ascii?Q?TbgnriSxqzMDam+Whv6v9gKbjQjtBHCe52dcQB/SL0517rBeNzblwWdvr2BJ?=
 =?us-ascii?Q?pb9cWSzG4nLOW5OtkQnKLGcEduOZ87dPtavTw+fAx3tJxdaKif0iCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?klI6BLvCVe5YeXiU2h1orRtKAmA6an/jI+o64LkqWL0+Xv7avCZZNVul049j?=
 =?us-ascii?Q?HMKbr84Abw/AVwdkX3rMRnBoruXmsLtNaE8B/MmiQI+9TOdPYsNvadt3EyCQ?=
 =?us-ascii?Q?JgBikpX0Qe1iTp9gmuK44/rOjuch2Cxo5+wyF1Y5CSmvMuznxy0FsNqra1Pe?=
 =?us-ascii?Q?65Iw9TnRtpdAK+JSfY2GZxPKLgv/KUDUhWMhOCd7ssXuKdgwY7K+R2x1dm1w?=
 =?us-ascii?Q?FD8NUxa6N+Sh2qPDmJ3k2YXhqHdrO1vfRSJUjx0eFeGkVsVHztihQDNZPfz1?=
 =?us-ascii?Q?SZuWY2rV2046FlfUFi12/M87YE5+xC3qU5+qSM36z2K/K4jiMqLqWbjQGRrc?=
 =?us-ascii?Q?oQ8XWl+I9sdrwPNayukPrmU3Kzz0MA92eIcqja0wI1eIwQrdlzQvBcRBYhep?=
 =?us-ascii?Q?JwOg2gAuRiSdplp91a94e4m6tz7u4BAFYkhMst9PV1JBIact2qVszfhgIrLU?=
 =?us-ascii?Q?C+Tok4T+9lndA7R2tt1DOc6M3fI0U0tcHdoYlx5Ek/NCbrVtFK11CMR1hu0g?=
 =?us-ascii?Q?LrByJQCT8a1/Fd/RR4ZI+nOH+OAK4mp0s4v96BgxQcO9ooDtWKCqRSDJEGL+?=
 =?us-ascii?Q?r6IyrVwoD93oV7vfDOH4V2XDNUjr8J2pzddklZECbETM+GzZ2NfC37J6RbtH?=
 =?us-ascii?Q?x8lFpLhkzTv8Qp9Zn0WZL5B5jhkJOinKRVPDCoIl6bwE+HG9YNjy/kTffRaw?=
 =?us-ascii?Q?1Qg3+WsbGKykmf9P+Vbvvpa1Ud/FWaizcRnbUA8bjMhgOkgNy3XDlYai0xc3?=
 =?us-ascii?Q?HhUEaPyeV9pYJlGn9LIFixa5b5Um+41aWoFOjI1dbTYja7g3mF+2HgPVSmi5?=
 =?us-ascii?Q?1//XnIN2cRMhtLLkVQGYhsbUX7jq1l+Ev+7cZBF1+sVP7t6VDvbVP26gTaiQ?=
 =?us-ascii?Q?kMDnZG6D1Dyt3QTf7h7r0+/FRklTPc533Ps05QKJ0KuOQUkVb56YCkj0jlXe?=
 =?us-ascii?Q?N7ebcwe493M6BkJLvQaOmycbMeLC1qOdfd5U+mB5nBc9Ax4VZ/F9oKPJoKNK?=
 =?us-ascii?Q?ifhiSISxi79hWZrbCQqErRMfPnqDS9kPCB1CUJAXdhs78e5UBESllN+gwLIh?=
 =?us-ascii?Q?pHRVkbn53tHxJA67tt0AlM4YqPhsJrXhdvKzq6DapfeEupvel8k4nqiZAP8m?=
 =?us-ascii?Q?wHRR+LEmoGtEOzDJ1GVCU8QQmQEmlUsY2RGsr71AKNvPFmQZisqObM+iskht?=
 =?us-ascii?Q?GSZo6sll4xMruT8HR6HK1vSnuAQwZ77H7j8nPPoL/vAjpAjcHWd+kfIK7uFa?=
 =?us-ascii?Q?zjrSmOp7zMw4/CTayvNS8jQ9No3hZwBwTkChHCnbmlXmppVa30yaTauMkyMd?=
 =?us-ascii?Q?Y/g4MLbYJUBJrU+k85UNrzcU7Ljq3lLNUybT0vM92DxUYIy+9ItbZCW5l9I3?=
 =?us-ascii?Q?LG4vf4c9MmilA0Dm7BwwLzO76uWE9OYI05AXf2vjRt0TK04iBrj8hiThff/p?=
 =?us-ascii?Q?3cA1IDPYL0AxS+/+rwwf65XZho82VF1I0iTgWcIRZ31g4oBZNSck73qvH4Wf?=
 =?us-ascii?Q?TJ+Ftk5CNj5w/QV4vtpEIUKn0BVamvit+k1sjnQSJKAZ7BX8SIaOrbHbSlVu?=
 =?us-ascii?Q?3dMNF2Y3chyOcihJ+n8VVxyfbMe9qCT5I9Bp7n/UdqKqPNJApYjFiDzZ5ONO?=
 =?us-ascii?Q?XqIajCg088LNs3+sQDXhAXodBlFgKNddwxzmPHwQhClATONwwu8GMMsXL3Y3?=
 =?us-ascii?Q?ocr9pYsFJn151p5n9hoL9uiY//5M7+kMbfXSzz6/1taWQUZs5CQQaIPtcOxP?=
 =?us-ascii?Q?BtbF2vML6A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2183f0-b52b-4bc7-55b8-08de438bedc6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 08:02:20.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcVcYmXV62UfzAIG1Ux82XWYeMEUV1Qi6k0Nr0HCCPJnjsyH+t/ootaYkz3LT8523i/EiGEG/qrjYggUu/zSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3540

Hi Steve,

Add support for displaying bitmasks in human-readable list format (e.g.,
0,2-5,7) in addition to the default hexadecimal bitmap representation.
This is particularly useful when tracing CPU masks and other large
bitmasks where individual bit positions are more meaningful than their
hexadecimal encoding.

When the "bitmask-list" option is enabled, the printk "%*pbl" format
specifier is used to render bitmasks as comma-separated ranges, making
trace output easier to interpret for complex CPU configurations and
large bitmask values.

This iteration incorporates the use of iter->tmp_seq to ensure the
implementation is robust, instance-aware, and free from buffer contention
or duplication issues.

Please let me know your thoughts.


Changes since v1 [1]:
 - Introduce new helper trace_seq_bitmask_list() (Steven Rostedt)
 - Use iter->tmp_seq as a scratchpad to prevent buffer collisions and
   duplication
 - Update trace_print_bitmask_seq() signature to accept trace_iterator
   instead of trace_seq
 - Add declaration for trace_seq_bitmask_list() and provide necessary stub
   definitions
 - Update __get_bitmask and __get_rel_bitmask macros to pass iter to the
   bitmask helper
 - Implement instance-aware bitmask formatting using iter->tmp_seq as a
   scratchpad to prevent buffer collisions and duplication

[1]: https://lore.kernel.org/lkml/20251223035622.2084081-1-atomlin@atomlin.com/

Aaron Tomlin (1):
  tracing: Add bitmask-list option for human-readable bitmask display

 Documentation/trace/ftrace.rst             |  9 +++++++
 include/linux/trace_events.h               |  8 +++---
 include/linux/trace_seq.h                  | 12 ++++++++-
 include/trace/stages/stage3_trace_output.h |  4 +--
 kernel/trace/trace.h                       |  1 +
 kernel/trace/trace_output.c                | 30 +++++++++++++++++++---
 kernel/trace/trace_seq.c                   | 29 ++++++++++++++++++++-
 7 files changed, 82 insertions(+), 11 deletions(-)

-- 
2.51.0

