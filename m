Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932C2459F3;
	Fri, 26 Dec 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766765253; cv=fail; b=dEw4KMbJRxO1lReHT2A+sdkUX0rE1vH/9M4wm3V1pWUuN/TCtREmJaJEk5bifCAGEesK5j2AKGGV7bHwkXT0gU7URGAtMlb8gEdzMPmqLt7zrJqAQIUoGttZv8Nn7aZxooqqvXHQh//LV54M6nBV54Ah4Wv35++orAvJF9h58uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766765253; c=relaxed/simple;
	bh=pxAq8LlzQVYWxkCiFd2zDJzPfW7g2cQIYMunaXP1GqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F+wWmVRYUnkMQ1ZS7EchbbqZkc9RIPSO14XW2JWnwudaqq4sgZIeBBaLqqdtzjlU8CVYqAKUvOfpRNZD8jQ46WYAZslWe6taGHcCfHS3JXpMiw78RbrT3vg4X8wSnK4mlctug195842/cOMpX5M0OmzBkt+nalZ9wE7uSGBjvnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksRigvSJdTyzk9WgIe+iVjZD2K8bcLyFf2w+yLnrT1pf+9KvUpKEBCvJA0XCfijOao2aAYIOGEVgDiNMynz8EJjcUII8L7rgaTWEz4UWb0i/sxc3H7D4UmUwut6WjXzUbiKTTj/BTLoeP1PlUl1p6a/yiq0crNMbc2Bi0/FQCzPRL/zbaXv9kN/3EjGfD8sdGVlogEv7KAPzl5FyzVzMLLsvyRO3pHudUIaCxOIduqzs9IPsoFFIRbHe3dwjZcun2aT3MDfVAfLZSHzbnueb1wJwHvr0rWZPRE63sC9xBzkUYdwoZRM16Q2OsNb7sVcFf3PtLb5YhQbqTx4j3thbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voe69BGhdB3zkWI5zKBbrcI0qw86Chn7sPwfhbY7LQQ=;
 b=kWwIt4WFudHSchw+DeVcEcjunDG+P1nyYfp3Q5Z0EOpZcLf3HoDsHnVAOVrmDDWbKWdadkoAjVMmVOjTFlpZwnFKDxAgPiUMfJkAx6C6M4cKZFwoxjCSDVINSaSIRjUxR9WxzgXk+nbXe1PwyfZOACCL6FU/amzMXtwgGFXi9EFKPnbdcia5Qnu363kwgFdMRyBYuYr4bteu8OBcWMv3XvPH5IbDNc8gwdSntrlGJXrleHZ2wy+YSc0iSGnf9UPImSrPeYAMHfXeNRzDD1dY5YcLa5h774YDpx1qYS989XvUTuq5ChoeuLq3fSx68ZRqAJYmQ/a9Dc4pSORSAFdCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7410.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 16:07:28 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 16:07:28 +0000
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
Subject: [v3 PATCH 0/1] tracing: Add bitmask-list option for human-readable bitmask display
Date: Fri, 26 Dec 2025 11:07:23 -0500
Message-ID: <20251226160724.2246493-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:e8::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: d88a961a-851a-4281-8c30-08de4498ddd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BlEvB520EN5CzXcLdrlMJCMhtFR7jNjqI/PqyxKhFmsd2WVN7fVFuvnufJ42?=
 =?us-ascii?Q?AiL4CMnt14f4pLs1soazk7qtPio3O/bvjW5DohkPPk9tswcRHqaba0hW2scB?=
 =?us-ascii?Q?3d1o2Az4ir/AhJpFxcLKT8qbHS9Yeflfujso3vjt1CJaeTp/gM3dcrSiKY3q?=
 =?us-ascii?Q?Ddwqh3O1T23XkLVB9AsvujX6O4Ucpovu2zsBF+lU45vKQf8mIuBFl+mgO2WU?=
 =?us-ascii?Q?yEhqmU2xZgjMhFEB8JKVqGwcOuEQ+Sr1Uf+Vmk0MSpKShs9TbZreb3fxY1zi?=
 =?us-ascii?Q?Pisamuh2eNoarORLdoOqv56KeCd56rnyxAiirwhH74FEWIgnzy3VNXa+EHbL?=
 =?us-ascii?Q?m9z0yTWKd5ZBFN5ibUMkoHprykMSTzNYFR6lSpdZvwVixzsHH4ls4ma2CJKh?=
 =?us-ascii?Q?kWEmo6eeY2JOqch2PfmZ8XWhlJjKXa1CmAhdBkZ9yHSC2Fb71LRAsElCJKBJ?=
 =?us-ascii?Q?c9OiotjwtAfu5EndOmnhcmX6DdKFdLyS/608wCwnBCtIQlz1tdC+hWiwtGaw?=
 =?us-ascii?Q?JG8m2O9HCrkn3ExyC4wc+2Xe8qNKrwFaYAL0qIeUYi4Eljw70bSLAT3841kr?=
 =?us-ascii?Q?jLjFd+tN3CjO/HYatGyL6jr56lKEcZBdf4IA79FH7/XeoSGSC7yiW/X71EMI?=
 =?us-ascii?Q?18peQy7O80l1Z7RZBwQHzlHJIxIfHm5pmMuCn7G0lwTLOuUVTF7ZtubFVz/j?=
 =?us-ascii?Q?2jBhOQGspmpc1Tz3VOSj39CSthRQ+jvFFhRbSSgkhJ80Rh3bqKwgMGhpXpHR?=
 =?us-ascii?Q?EFC26ScuL3OmPOatPu96vrTcXU2+WzWoGEVSMcpXIeAN2Qt5Yzu9cTkXxFwx?=
 =?us-ascii?Q?5jxsjU366yGIT3LY5+4oFJReSkig1CbCS93XKswYjWnLRwfwmyoPLzfp26Pa?=
 =?us-ascii?Q?3ZpTnskoV6PuPoMonBEDfdMmWvhJWFJMyUVNhq7t66VNBp2+5HuRqOg5pvCz?=
 =?us-ascii?Q?NuHpcXthZfCEvngI2Qw70zBleBBP/1RyBzSTTu7qsLxE/cSbs12S6cZIuShH?=
 =?us-ascii?Q?jkTbbGDRvn1hTSadfDMQQQr5yYmmXtQGYsFhQ3KmtEgiIqmdYf3EVya4m7A1?=
 =?us-ascii?Q?JT488fy1P+/hSo71H+6Jt6Jub7ZqJdRvScX5tLd/ZOEhnqEEQFozgr+zf+Mf?=
 =?us-ascii?Q?xmSpLFcblTeTrOaq2kI34ZEFZHIzuJN/eRx/eDZx5MqD1lTXcfeu8VsY5+TR?=
 =?us-ascii?Q?MPiXJb8EX8x5s59E/ioe+9cC88CplOoTrJ4SONd4ZQ1THsbM+L/kf/edGf03?=
 =?us-ascii?Q?TPQzOFRNheBrsBjDjQY6Rvo/gfLYlLA+XMEfCa9pfZy5zfHaidQ1fiBgFNsz?=
 =?us-ascii?Q?dVCkZz0Qa9ZYPzW2Fpmzc5hZgP31mzgEkSNF9/yWMyg7pQ64B70WJUQ6otZK?=
 =?us-ascii?Q?jcpPqaKlK50uBeIWVdJw932PF1273eVNOZw+JR8F7uXxOQlRtkCjJss22/8e?=
 =?us-ascii?Q?slaZbyE0umTtew2FXod6TMvqt+DqEETDeRmYg9myHcMzHx/OPcSNXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWwnhVV9PYcDkbe8ZKP+N0yW28i91SDFGXIxEZ1d++3NkJapU8rQal3uc4q0?=
 =?us-ascii?Q?LNRR1QvVU6E5fODrGO0g3uxSQjWjLeYeWNiUJjQegfmkvjS/xOBNjCBD3m8I?=
 =?us-ascii?Q?eAPe0Uqbjd9Fiw5zqnextJZo+i6/Ql5oUL6arFfWaYDN1LLd5EoCbfzyDZHb?=
 =?us-ascii?Q?E3FNXu1dnsUxpBAg9kZUTDmmdMvJ6Me3XKlK+Lo3hjxt6elyaqYxov1z1Xyu?=
 =?us-ascii?Q?NhFpbCYIc76lOU7BMU2wN94mYkEzXjbMj3XEQ5kr15uCj4qlHvJbo3yXtyDG?=
 =?us-ascii?Q?Haf+bYlJNRURU2XNMRpmjS0zNWzbJClb/lLN/ym1OvkhayQ6VTtNLtjLANrW?=
 =?us-ascii?Q?5HDLykjEozfOJJTerfCpLwiaMzHlPm9g4lL6q1OZflXLoa1BQhkHU04tPGsx?=
 =?us-ascii?Q?Qyk4NxgptFeSTl2rplTqT5bOPzieM4LjmpZMUhzQVMWsbZR8MJ+2K0W4F4RE?=
 =?us-ascii?Q?kU5Q838e9AVR4wFNmI4Ki6E+3uzO6WQ5K4inABcrtZxmicJlh+yJ+XtyMqIK?=
 =?us-ascii?Q?KGvI05p3IXJBxnE9DMXbghNvuorN9vScsFrsFcNoWOmClyVQBhKwqj2l5ljO?=
 =?us-ascii?Q?v5YLU7wkIlvJP/6DdbgWoJbCs9UxjrgiNja8tHAOh3JnnnskcQ6M7sOaxU8k?=
 =?us-ascii?Q?G+9EuU8UKTaEhYhZoaljqpqTsaeAG/LBLp5Mkqo6gpIvbUx9aNiNZSbCAMHX?=
 =?us-ascii?Q?DmjCUqRSyDOU27mrVz21PAczn2BJcWhYOj1KY/nQfxNY9ozNw5shu7zD9QCt?=
 =?us-ascii?Q?lKHuDs8WT8w6UVhDsj4nKFzjaVuJVsNelJS7ze8pQIlFGcyn7c7kiXIem2V7?=
 =?us-ascii?Q?HTDfKF4Bd9teMz77UV09tRRimQkPRArUBNP7y8vKIy79z3X56nJl4w4YVOgA?=
 =?us-ascii?Q?v5IGBpNteC4+GCsLwMuNk8Y201qTuLgjLqme3vo6i3uXCXwu+/jymkwVkeOl?=
 =?us-ascii?Q?dLGab6p3G/7st459K9zlRYZs9TuvEHESYp5r0FWrg34BkMcUlLyANSmV2iCZ?=
 =?us-ascii?Q?shzR4HlIZSodJpJhdkgDc/aH+xAsAYek+N84MEaSLaCw9HoQJnhu2j4rlnNK?=
 =?us-ascii?Q?q4wZdbW3Ja3ZGSB+yXFCxKJIwpnSdZlDq8YpfMTLBUV/V3dPanhnlDJPb2aM?=
 =?us-ascii?Q?BOKZG1XMjNdq6iVsASFZyWLqD0mXCJEIysbKXHtAhMyAPWM8/H8q9fO16Nb7?=
 =?us-ascii?Q?RShA1qQpQZUV7mU5iQj9dUENh36twAVUZvhajqr+8sEi5C3NFxJPL77GRYQc?=
 =?us-ascii?Q?J1oTHwsg0zEF4ebWzUzkxWRC+2FHoNC+eFtQdwRxd/BEDimzmK3WVhP0LIb5?=
 =?us-ascii?Q?mZAk/16x+ntzo8LonWk80n1edG4UFbbOO+Tue2aFLu+jK50faCOj3EyozEMh?=
 =?us-ascii?Q?1ZkhMfSJqqJHpFSLxhpXULFmjUi8kAG0E58lH5nnoiWiDAE3+5yFIErTmCw5?=
 =?us-ascii?Q?cn+fRetVoiqGf35HnOV7sJ4i2zdCUcqYzkiXM7eE6JjCjUilchl7sn/b0qxv?=
 =?us-ascii?Q?UTUQeCpGhVZpjM+6u0ZRLHpnHdwK/29fOBQemrB7asKLd4OPZ3FEdKUP5Ow3?=
 =?us-ascii?Q?C09pQhhhLcUWdgFdYbuuK9vX+1LytXcT1l0TRe9Gyfr+HKq52VCwi+naI9M/?=
 =?us-ascii?Q?2gdWvagdiQsCeYrqCIuZAg+U5dlmBuiNVedrQXgWErs1vob4gxlNcug12Rkr?=
 =?us-ascii?Q?0o1F1Plj4mc5Ihcg+wLJaetSjKdjUsVFZGFlT2h9IoDFZjUI8h9G6XGFrbix?=
 =?us-ascii?Q?AvvWTuEWnw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88a961a-851a-4281-8c30-08de4498ddd8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 16:07:28.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cSRDZ/OwqUY3D0sbkDEX59P/g9QU1v16GEChn91ogsCGYRbpKUCFZ9P0fB0qaMz26cwetQYRpt/HzPP2LqI8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7410

Hi Steve,

This patch adds support for displaying bitmasks in human-readable list
format (e.g., 0,2-5,7) in addition to the default hexadecimal bitmap
representation. This is particularly useful when tracing CPU masks and
other large bitmasks where individual bit positions are more meaningful
than their hexadecimal encoding.

When the "bitmask-list" option is enabled, the printk "%*pbl" format
specifier is used to render bitmasks as comma-separated ranges, making
trace output easier to interpret for complex CPU configurations and
large bitmask values.

This iteration incorporates the use of iter->tmp_seq to ensure the
implementation is robust, instance-aware, and free from buffer contention
or duplication issues.

Please let me know your thoughts.


Changes since v2 [1]:
 - Fix build error by correcting redundant and missing stubs in the
   !CONFIG_TRACING block (0-DAY CI Kernel Test Service)

Changes since v1 [2]:
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

[1]: https://lore.kernel.org/lkml/20251225080216.2196411-2-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20251223035622.2084081-1-atomlin@atomlin.com/

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

