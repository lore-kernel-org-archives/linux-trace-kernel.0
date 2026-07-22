Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023135.outbound.protection.outlook.com [40.107.44.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193923E6DC8;
	Wed, 22 Jul 2026 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696250; cv=fail; b=drNE5GRch5XyGvePHDqZ15NhayOAqzAPrk6Pg9jc4DMam28PXiZDs6tBVJ8GsKZcxdLzbbKhwgq2aYcUAFPtVK8wfzmUP3utWi87kx+ctlDlIqtMBw51IdgtQuniDlDbMtg/K0hRToWDsEpq1OXXRvStfg91zLg/0WzjC4sfNEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696250; c=relaxed/simple;
	bh=LGz5irB84hcv9vkVTCUDK+vttco6G9yxl9cahpd/B5M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GNyrhzMKT9+3k/s0qrTHJVy012dkUftWas/JYVnTqBpkMRutMhIu07813r3PqsS/aIi/zjkoznRQQl2tT4aaNusxPbASmw1Jbazg5ApEd4Cp+8ckPkc29+igaU6SKEwifG9lntHGSn96efPKgDgwOC8e320QxcqIxqyRhSQLMg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=mpL3dwLi; arc=fail smtp.client-ip=40.107.44.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="mpL3dwLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaMrnMlz+zzGC89x894EnscqMS9ak5sRwR3Y6Fok+UUHL4OJFyG6mWv0n7WSK4Ky6HfIvSLGRFTBoDOt9WyOEUKAcygckBnhIvt7nGJj0DqKXvYrmaVYkjxmjyumkZN9WCb9WAy6qMavHYHIqPT+8mX+XpiGBg1ViH+wlyrsyGsNVukOe/DA3B0YUwBGuu3knh0rv8lS3FBVyfWExPdYP3fjYre6ANuHc9xnLcSXM+LKYdD8nzVqjiHIRG86zBWHa4i7V9tNLrDqgL5TSsWnsBjEcP9yKBCnMsnI0hxV6BnEHZKeBm+DNOx6c5GreqyW/OKPxgbewW6iFZPVhkcgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOK/wodX42jf0egL5j9ojN07uoOJkCC4TjBmqX8JFiU=;
 b=VhmyTq23WYnV6jZtF2v4hpwlbWdq3V/Je7HVeCZf11w3W0cBpcycB822DwFkY6MHCby0Esh4l5A+4iVcTlrlqcpOz9GbWIZFwTwJczm2Hnu7X+bc5ZKq4T/BgJn0zV/prXR1EHmRjY/H0owQkVcJHkJs5tcdc5EMXgYMmgIQ0iI3eKXkz3+8CiAWK5DtbMZaG3WBhZZJRsbBP7yvITNtRJ/7b2fOAtkMU4UdZ/P8ACobCC+bUOV4JsN/HHZ3aaGONXrxP1mE2MTtSTcSDcwNqOXwg/Bsa3TZp+UHeORJlog/+gQgoPeK4yZWkLCFrlztShWCq23CEFVhT+DKsPYP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOK/wodX42jf0egL5j9ojN07uoOJkCC4TjBmqX8JFiU=;
 b=mpL3dwLieGS7BWzn608pX3kdR3RPdrwoSsoJXleTuahqocs/xrv9FcIeeiljPWIZFT1Q9mIw5U9uio5n2eiBlsPNzOYOFnj+QIK6kVea3E2Fz0Pn71P1RmuPbxJswisKFRzd0ztu2f+aMtiG/C5x9XT6mwFhLJrf5x9BsazZ3YYadabuflOlv1cASfSl9zljQJoA75wC7fxgvQriichu0wRRhrU4t0TEhzfi5ZYNm+8HvYSvVVnfnobxCTXM91itDoDmgZVBHP18ZnqddxveFxRRznyqE165HJEJiP/jEWDrYNsHphs6LPdygo2pvOFTaDNjMvqjOGm8/heWTqI7RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY2PPF37115AF0C.apcprd02.prod.outlook.com (2603:1096:408::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 04:57:24 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 04:57:24 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Nam Cao <namcao@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH] Documentation/rv: Explain epoll and aborted sleeps
Date: Wed, 22 Jul 2026 12:57:06 +0800
Message-ID: <20260722045706.85633-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0109.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::11) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY2PPF37115AF0C:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc69d15-8827-44df-6de7-08dee7adb82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|34096008|23010399003|366016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	G0HSYkXlgjHntLHLPBNDBYf9r/Qx9XXWR5ogf8UX+JZNqux8eQqvP1DcXUpzQAhgV61KUoJllHYG3Lo2Oxx/lC6b3xH2vhiT9F/8wUv1iwlTyLbc965qFiNUmXLpjHlZh/TQECNGxxwUC94gNRaZVSupNSuuAidgv8qs9W/0XH/F1F3X17N23uF+6y/7Cc8F2YT4MKrXufvlZpWNfUyPEHLmLX+iSlc8UysTZb0ubYBUXgokFWkPTDBh6+zARME4tEhUSKyU2PxNR4ThncqGDsBEMzp+JePU/gNZNHvEHdDLBnfcgvY2ckh910MkVU3laeCiWBMp0xXoqKyoQg5BI9HOzc9kK71xL+pOSGeYr25whXznyzNmrX4EqBCUMZSAp1ywYlbGuLONT4wR8WQVKeHFbf3gfDkKePHAoqtpeImLZp0IYtoPsx1F2fIkMaVJpIfZwEFtUqJ1kGK1X3URrOl/n9USrQDAclhGrjYiP0KGfOgm967uC8a/vC09yfRp3Tt9i1oq82UHpBaGwoFz6M3nG4o5672+/ifTkdf0BY4Sd8UCYjGtzupMyT5iIAVQekGmRcsKDAphlSb97gWxLdcxIE87RaV8Nhj8/zzmeOIu+1bZ41vnjddRslHkb5+zbDxgi0dBsHqS43U4zwIUmyVyVCAqc4H2MZM0DHDW7nU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(34096008)(23010399003)(366016)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kXfyfXmcBvTYVyfYjDB3k1C/mGc8IL/YVqDCcoGRMr5xdQ86ZwjUNgVgglg?=
 =?us-ascii?Q?7QDl0lvlRZ9o71ODfl6CdzFlaMKVYy0geweP+V1x+OGenQYBb7ZNDBUCn+2t?=
 =?us-ascii?Q?SPJ0C38zAMzMJ9si4BvImE2BVKegVlifUW1N2OrfDN8okwz4upQD6jDqsL45?=
 =?us-ascii?Q?7E9Ty9CBFtdatSShiOMUBxGYS7P3uM5lANCk6T8H/9/dyc9qbUfjc7U4SdzT?=
 =?us-ascii?Q?d51Ohr65WcBA68wHEnYuvuwj6c/CDsaMt8Q1yWUcZFwnf+UOgHbcdSYIvxgh?=
 =?us-ascii?Q?gdUIm1dcNH30kk2gopA53AfZZe3qf8Fog2LOdVJuJyWz8ggDCuVM+q3GBDsm?=
 =?us-ascii?Q?vzwZus6iZoKj+UUVC2qLfN2yLDdRkox60JIcRD3YtgeY49k4QlQAu4RweC8T?=
 =?us-ascii?Q?UDD/+al/hu6ym/MvvsOZsTBnJJUDZHc1P6lXoFKufHhpRZ1psQpgU6qzVmj0?=
 =?us-ascii?Q?+MKE37s+PGjIzueFFYzm7IzjbFMjZuLuxdrN0P5fELaRyNu8fu1d2Efi0M+9?=
 =?us-ascii?Q?nVGKdIvoQZSVhtEIBB0u15gr3bfV8aT7GkDvLUZFzLx+gCagvsrwTe0N621K?=
 =?us-ascii?Q?CSfWyyoTobeNfEcZJbNIekDNhxLRAkOB5DIZmDn+ylg6fZxH6cqx4JddNYPi?=
 =?us-ascii?Q?B54ZA8sW61T5fhVmNNYGqYns/1Yr3qJaAG6hBdnA70wF35Pm8rOlRwaXvU+x?=
 =?us-ascii?Q?CUD0odvR4d2tqjhHT5IJR2giUfZsVpDrEXoheQR34X/l2oQtMBxbY+boeZUv?=
 =?us-ascii?Q?UMjxoo8v4ZoAzPauH6xbuCXqIegNI5l7NnbIWkmnkesU7pgJNMg6hd5Xtjqp?=
 =?us-ascii?Q?6dvQuqr5lEvHDLwdLOzXXgh/2Ofbabmo7+PmseJzMpZO0lCbRA1gkvmYaLC+?=
 =?us-ascii?Q?d6KBLyWJtnGO/UHjvf2SgeAF71Ovio3qjksbdoYn1ECCoKDBFaYxJlTJ0YNy?=
 =?us-ascii?Q?ETneKqVQohp87k3f57IeHuWp4qS7D7AzKlhcn8I95h19bL2DIuhNaZYE3l6q?=
 =?us-ascii?Q?Hdpk+3JGvegALiq6TQiSNdZuRacfo5a9YHiVPJfBz2CZfG+sv0YgvyCj/3P4?=
 =?us-ascii?Q?9Ah7HJWL9DUiaUs4TSOdcqaLZJ2p0wBLTsfuiPH+qShdEMBkc4Sm+7/7HjVR?=
 =?us-ascii?Q?7cNvArRP21yvqWrUuRWv6EWpaFFxFJ+5Ya0MiIi4joAUU8dFVNnvj/7cyMvj?=
 =?us-ascii?Q?GTcuICaY3xs71zesPgit6mOOmO4CFpZSzbcSiXY4aGvdF6AbjzpInvF+Cz7/?=
 =?us-ascii?Q?V2F31MtxH3kHUQgNfCasVXfz09YyVZPq7UhG5Bo79J+N94Kc0FRliGEyrJeX?=
 =?us-ascii?Q?mXTIndPLln4b2eONLfYx6uzwtQmUjcfyTCNURg/QdGus/KNfQ+bwlW+Na/St?=
 =?us-ascii?Q?YvQcFyRbItCJo7xI2uGQSfHE0d91rXVGUr7oawYVqbwtRS3a8IhJsUP36tYO?=
 =?us-ascii?Q?RZt/cs1zB29ML2vaP7JwMosYdhEJ0Dku+/Z+KR2C+GNbKOpqGFLdzrls6RTc?=
 =?us-ascii?Q?wrwbSVdNtVt6Gb7H36xdiF8bDLzO4OzMmsJcsNuz6fCPY2rLvlSghZ0TU1dv?=
 =?us-ascii?Q?EN4nmd+/aahREk+LphE49istbm+tI9awa6ItRcQmKUabo0724qqCWFb+s4jN?=
 =?us-ascii?Q?fwf9KyDCrzAW+RI+zuMtCV+3Fut/0kZX9ALwaqn0sOgvTpeLfVRQ2meR6sDF?=
 =?us-ascii?Q?psWlyRzte4V9UpaJmuFJ5K3u5VSiikvlDl7fp249nIMtAfi7UD3ToBzJmmIk?=
 =?us-ascii?Q?6YThH3tlYy4SLw2pMOid1pwDBN86crk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc69d15-8827-44df-6de7-08dee7adb82c
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 04:57:24.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8xHVG1hmKFBaWyaItPdC/FHZ5SzXBZv2pBBNDBxcYf4JCVIZTAabqX4UHDCSuTnqV3xdX+u8Eg5DsStTOr3KI/YLK30yjdBL/XmVKbr2xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF37115AF0C

The rtapp sleep monitor accepts epoll_wait() as a valid sleeping
reason, but the prose only discusses clock_nanosleep and futexes. Add
epoll_wait to the list of valid sleeping reasons.

ABORT_SLEEP represents a task restoring TASK_RUNNING before entering
the scheduler, but its meaning is not described. Explain why the
aborted sleep attempt is valid.

This RFC is based on Nam Cao's pending "rv: rtapp monitor update" v2
series:

https://lore.kernel.org/r/cover.1781852967.git.namcao@linutronix.de

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
 Documentation/trace/rv/monitor_rtapp.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace/rv/monitor_rtapp.rst
index 238b59395ff5..234ed4d581ac 100644
--- a/Documentation/trace/rv/monitor_rtapp.rst
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -67,6 +67,8 @@ thread to sleep for one of the following reasons:
     variables as safe for real-time. As an alternative, the librtpi library
     exists to provide a conditional variable implementation that is correct for
     real-time applications in Linux.
+  - Real-time thread waiting for events using `epoll_wait`, which the monitor
+    accepts as a valid sleeping reason for real-time tasks.
 
 Beside the reason for sleeping, the eventual waker should also be
 real-time-safe. Namely, one of:
@@ -114,6 +116,10 @@ The monitor's specification is::
   ALLOWLIST = BLOCK_ON_RT_MUTEX
            or FUTEX_LOCK_PI
 
+`ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` before
+entering the scheduler. In this case, the task does not actually block, so the
+monitor treats the aborted sleep attempt as valid.
+
 Beside the scenarios described above, this specification also defines an allow list
 to handle some special cases:
 

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
prerequisite-patch-id: d8b6c952a954662852e6b0684e0a3386eaab7f41
prerequisite-patch-id: 940f7637aeabe4ba15a09c048c6f48138406f332
prerequisite-patch-id: b99812692691f76d825778e01a2e771e058febd6
prerequisite-patch-id: 512c300dce2cb74ac9cc007f9234aa507ef5c008
-- 
2.54.0

