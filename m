Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9A16FF37;
	Wed, 23 Jul 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250816; cv=fail; b=PHZTJ25JITaAxbyOG0LqGkrhaGsH0NX0ptfL0zvjDUa0jfNZsovU+Y1wz5ui4Ldbukv/zK+E1t9TjPbLpGQ2xbT0Q58uqzal80OZRw4oZ1MArDr678XVRf8gMkJWO88RZ23Pn67EpoGImfxIyYWBhkHYUhZvOd00xxVQV995szo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250816; c=relaxed/simple;
	bh=wzDq3hjcUtvsnehuxRDMhf0JuWu6ILwn1HnPfj5WaNA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nGn1SU/j1BIcQDQV3QPXgYVscHfC6dxHgLt8AvAbDiCDpu1LgI27HMYSPgnU7DUVFFvVwzq1r8bC02aF1l6qorgD2REut/4B7eAndE0F1GXNyxNDz/NF0o1PoBhJpBRcO3vwKxF7SnbAxaSc7PmGguLTin/FBPuZSaJ7sVyPeD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDARex7S; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDARex7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753250810; x=1784786810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wzDq3hjcUtvsnehuxRDMhf0JuWu6ILwn1HnPfj5WaNA=;
  b=fDARex7SYpgPiSZdRbF5qOevOheL28OcM4Yl8C9BYjmpArVZWpnztTex
   b2GEujM5ILOKh02BhHCeBKeulHbFnaLKPd3XsdvdE8dKIPal5wwAuz2Nc
   tNH4tdOO6U3QYdK2ufW8uakg1/Ph1leUFb4TCzVBAiTDZZS/8J2legkc9
   cXFZz5g4ucEyLE/qRcNYF/1o3zVRKZb1FgTIUaW/XZviKZNFRKLPhLoHU
   BYYpimVdcUVrwB2HZoSSeS/B1Q/xoZcYR0GDVjc9pHgSXbHM6GpZdCNju
   tczXxR/X9+hcQCeOtgkSrLM1zKuLHezNi0XDWGbeH24qc/9fj9HW4m/BL
   A==;
X-CSE-ConnectionGUID: WaWfveuvT5ef4XnQOhea2g==
X-CSE-MsgGUID: sSD6ziwGSHmYe6+hLbGQIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66860668"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="66860668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:06:46 -0700
X-CSE-ConnectionGUID: Joc6O/4VSlC9IeL1dcD8xg==
X-CSE-MsgGUID: 5eAZUp9gQMS/bX0gbGyGqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163613060"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:06:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 23:06:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 23:06:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.58)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 23:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CneNBF3YbMk4pMtsG4siM00ZhFfggvfiqLmGQyYyathvVPXXXSINu0VBTPqZHq4WJCB1j55DUa6dKPNaK39vv7kN3PS4vHYj59kqFBfjJJ+FIiK4WWp0ojaPiVZGF99WWOBgOncCEYVOFA17Wqhw1fGhPc2caAvBh+Fhguu6+hG/fXnzzY5grQgCF4SIIEj1zyRRB9IuSJbOsf3a6hW5K4IqUbwDUou5J6rqpo9xhtTZTkUIIizFoaho7ImnAcV22z5l93CfnBeKpTyrJRAn9Lu8FHt2f7sTsxEcvze3RZzFYDf75xmAE1lshu3+Z+vV4GPO5bxu3xWnFS5hbGpKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H16+dgeRYbmB13BbUEwqZnvBkNq4lz8XqyXFInPPPsM=;
 b=opuNDCeNBLzWZFIt49/gOaEqp5DCVSA0nf94wMikyPmuYgOcC1Opvr/ykynLOQNcaP+HEknByF1Qk+rLRxLpNQlBIV6x7DJPibyRfb+ylWHQ1HU4ZQUKzxLwmyOkTLw6t9hAqVvCiOh3k2MGg6FhoM3dn9ANl4nOQWOBM4Md9wLrwLT0deMxwB3JhgCPoSrXJl9UreByHCeAwidsyx2PwYH8w0LZfv0rDiHouKzFOh12Fo/N5g1Fno3u8z7yF74Bh++sa/x5YlutkIlEYwT32mXwPcyVATi6OI39nLDFIOndrFfcfWF2YtXOH8/CJCXA9yU0Xo3WjrrlIgfPntb//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 06:06:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 06:06:41 +0000
Date: Wed, 23 Jul 2025 14:06:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.07.18a] [tracing]  631f4b8aed:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <202507230700.658dd95d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: f8dc1fd4-c798-449e-96d8-08ddc9af17a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JLCiScN7ZhRp/hB8BLWmJCvX15YVd4OpXxAesFnS6PYSyi6Ai5UCBI9zIUra?=
 =?us-ascii?Q?pFG45nzrU/tgxtmTpa53WOmubpcYIUM/r13CXTwwvawrHptBGKaeZxoyz+yr?=
 =?us-ascii?Q?/VbNUZdiaS7esfFw/n8U0ERzKjUgjGkvXjAwPQRUT62UfuJ9m0W+x9AeqGJq?=
 =?us-ascii?Q?1Gjs8S5YpYZS8LWcLJsYyCqg28FTuL1O9k5NJQTsefceNa5ry0CBS++LzEJo?=
 =?us-ascii?Q?9Hyjq/xQdoM3YwPb9D194IjPz0ae/Jib7JJPX8Avj9TQLnvYI373JVAoSKDU?=
 =?us-ascii?Q?dvb7y4F4Qpa7jlFeSLdZuU1ufoQ457jJqUKpAN1qx1wHe8KtYTKco5ugtKn5?=
 =?us-ascii?Q?D8lkIBKWsNbPv/YjqxAyTV/fjKLPHIn7SMzW7S4TPEHNJiiOMidbMjv7Ofo6?=
 =?us-ascii?Q?BAUo/OUuyJhZCr002V7fnihkZphn6WTlR6+G8GGpSAgxoC7cCQeHvpnA8wxe?=
 =?us-ascii?Q?f4WY8q2BszxuuUSLos0jCRKIruZ43b+DS8jvKhJxbUFje4P06ndxm6VRJ5ZK?=
 =?us-ascii?Q?R1G8eGSEvlMyik389ODyfhI57t5V3Kz8d6W4fxH+B8XIRGpSOanc7SwiCesk?=
 =?us-ascii?Q?DO7UX+g+ZYo0xgDYg5IR/S3vXLczlo0AWk+pZSBYAJgUmOXRcDGQfHiKikLd?=
 =?us-ascii?Q?LbLzrpeNB/BBBNTBOEnKOF0a359xbaHaKPehMOajhHc2n1cTAVtJ3uHdm4Ju?=
 =?us-ascii?Q?AuzaVYBDQ7ZuTk9uxbknpJknNEZbuHi355OMTtSL+aGWTCZsUwfTVoTkV91b?=
 =?us-ascii?Q?yK8zzcVuXyieX1W6E1WHnfgEhouZFXvwWp0G4RQy7Zx0aBAle4ngv/wd8K7T?=
 =?us-ascii?Q?i63yFzPJHNPM6hsVxkb4matPlxEFg3dxkw/YmUQw8y8J5L+Njm3vlOtt+JQj?=
 =?us-ascii?Q?j29GS16AZ2g+CJSue50QxyZNMSq7KGr5yZPCX4UuNc+kMC5vX2d5l1arwraq?=
 =?us-ascii?Q?v/jARvwjLORkATmHB1JarvD9O1lu16+AnIgxq+gY/i3LHIP0b+Zx39mR12BE?=
 =?us-ascii?Q?g9O95ZxW64HXK9qLNsxINeGvc4CCqj1KhW5aRVj8NEyitvoMWQmZ0/qK1VvW?=
 =?us-ascii?Q?KR3dg6V1KJrcC8zdMmexCW+ykcB6i9kIQnG17VhekE0isH7keSSzA2lrrvk7?=
 =?us-ascii?Q?oKMbGDd1G/jmFC3ZTIDhkG788ZMXBgaW40e1OzMcWbojv2qnpoNb3ocxurOm?=
 =?us-ascii?Q?FN4MxGJZ9WPnx9xXzaJJlqQsVrxSAT54JAgBOtgm3tNOg+iSDMFLZwIHtEne?=
 =?us-ascii?Q?RSsloBUVu7IcLyUNVlcXEpPh4MbUBmc9ahDz48Gu3OdZvYGUbqn5OGuxM4CA?=
 =?us-ascii?Q?uTyJ5X+qZXMSjTL0NQJlo8swI17ri1uv0Gy22+tR/r8ldP6PGemVY4X3qVJT?=
 =?us-ascii?Q?ITNfLQynmVFqy+VHCemoQJsaRKoU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxiUe6F1PuL5c0iSXu0HXdZ58hzrSaRNqzWqpdj1op24uJMo4kSihIsNPxL2?=
 =?us-ascii?Q?Bd9wCQ5yCR2m+T9bNDQSqY0isaXVeUOZoh7hO+PFrtRG/7YxRdtrMqRosay5?=
 =?us-ascii?Q?JG2lBwm0P+YjrkmI5JQzvT2RjtOpJjJbEfH/Hk7+aITOxgotvqTHEj8WGLri?=
 =?us-ascii?Q?QDFKlEbXnubGiHgr3qSu3mgtGaB1sxtiWK338iGOifUZKD3ydc6pDYe9T0z7?=
 =?us-ascii?Q?YdwFiLunDB85j1KyYkbjFbSZFh4yMV9pb8GgtV1LED8QWMKIRKA8DHMR6PGm?=
 =?us-ascii?Q?eGj0isjRYpSw1njzq8xGmp4eFYhA9svb8s3IR7rDbyUbAecvqu4q5GROqnAS?=
 =?us-ascii?Q?WfSd8jJYMJHytaFpMkpCb09BpNWAIMe66gqFfYokdcrhVZsHfaSk7tpDNcZo?=
 =?us-ascii?Q?F2AlW7ASFls6eWjZWRhIgfQuxHrfzQYAHaQJngbPmf6KDymXNjqDX3A7u84V?=
 =?us-ascii?Q?k0yvSsdVX6PUA2nVoxusu75BHNR9sH+6X4r64vbcdnTPxdKfvv4SBt/dGpFk?=
 =?us-ascii?Q?ZXbhg8dTUOnH58jP8wmNiiNQ3glWuASEOYEjp+LCz7sAajjIdVD5xcyrm7o5?=
 =?us-ascii?Q?nT0CgA+FJFtdg2C1jwSKH3cUadq6dyhOUZm8gT1+xYz2SP7eI6dQVATSOUc8?=
 =?us-ascii?Q?3Pnt8rvUTzBmEPoAIjJA8zAShgVAY9Y9mCfVXO3gn4PoJLfngbWhyIZ68djs?=
 =?us-ascii?Q?86B7CxSIkh/LB4AP4s+1DVLq3j65VdXleI/p+AJs+YCT73OID0AVoC6QL+l6?=
 =?us-ascii?Q?2R3FY5QaenyJu4bfdEq6o9ms/o+kv7MGDXATUHx1bjbn9sQftw/V4zGGm+uU?=
 =?us-ascii?Q?D9oP4EUWHyyrW9b5FgMhMVEM73GzYgsl2I+OJdaOK00V2eT2qjsw0CtyY1EC?=
 =?us-ascii?Q?6QoIglnpJjfeZqhl5VxdC27WXlBgXZQUtW0/vrbmD0mIZj5Arq+GKBj0kG85?=
 =?us-ascii?Q?bx1EB0bN8x+hQm83MCfhhOosHIJaMe2mWb1E96QzInT9L9fZfr10NR9osyD+?=
 =?us-ascii?Q?nFeJHbbyrLSagT+UMm1aDfc02P+bMO5wIhD8oUa6FvbAgytTmJktrlnUKTXN?=
 =?us-ascii?Q?1Hk/BMP0Zd78Npu3eMitD+1d3vIoGLr1VEZgBoB5xfKfqtMQdFS+10wAUm9I?=
 =?us-ascii?Q?Jcvhr3IFe7TI/wtbHvWp/I1o8KHta6hjRd4uCaZA+jyEc9gZB3eFmEj69uLQ?=
 =?us-ascii?Q?qw2CbNYBhMluNX0u9wXssg7ipyXwprrMMAR4WqtzHrepGx6S9ByVgOcmoc2H?=
 =?us-ascii?Q?M8D2p2lqrPnFeHnGi3VWlEezPf+GlCuTv95JGkW34OwGprw8xFkLxd7nDjsP?=
 =?us-ascii?Q?mCFqbgjX0y73q4gOM6jTsLPYP+7lEmHsSvVUUl1EMv9QiZlQXpBSZkwdOBhZ?=
 =?us-ascii?Q?1vXY7ObHQpBa80PgHnyypprhSCo/X3dyu7sAOqqVnQ7uSFUwLbHl6UzEt6JG?=
 =?us-ascii?Q?F+Au3ouawTNJEa3pBzUEq7vz5kRCce/VZR35kSX3TOtFggkjVNS6MDlL5BcI?=
 =?us-ascii?Q?ct+/8rUw7X/6CgkzJ+NDGM5/YVpfkm9YHALFtNxx/KRLDJ79IhY7nx/l/xES?=
 =?us-ascii?Q?cw06Ej1SZbb6kGwM6Lqs6Wm97sKFKni0eByqvFgM2mWlIYpRsjhi3OSyugks?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dc1fd4-c798-449e-96d8-08ddc9af17a6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:06:41.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf23E53ANLSLp4iXxLyxRYmOYvCf5rOayoiGiV+tAFphbn4z0flRKUZBgPsuy7Vnw9Qs0FR8fKQLCemXx7Xmag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com


hi, Paul,

we also notice there is a dev.2025.07.18b branch which contains
56e0997c2587 tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast

our auto flow seems not finish the test of dev.2025.07.18b branch so far.

if 631f4b8aed is out-of-date, please just ignore this report.


Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 631f4b8aed514ab146135624d28f2fca0a08f731 ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
https://github.com/paulmckrcu/linux dev.2025.07.18a

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: i386-randconfig-003-20250720
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507230700.658dd95d-lkp@intel.com


[   37.244707][ T3746] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3746
[ 37.245497][ T3746] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.246445][ T3746] CPU: 1 UID: 0 PID: 3746 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.246450][ T3746] Call Trace:
[ 37.246453][ T3746] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.246460][ T3746] dump_stack (lib/dump_stack.c:130) 
[ 37.246465][ T3746] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.246473][ T3746] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.246477][ T3746] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.246495][ T3746] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.246498][ T3746] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.246503][ T3746] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.246515][ T3746] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.246519][ T3746] ? __lock_release+0xb1/0x167 
[ 37.246522][ T3746] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.246529][ T3746] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.246532][ T3746] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.246546][ T3746] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.246557][ T3746] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.246564][ T3746] do_execveat_common (fs/exec.c:1855) 
[ 37.246571][ T3746] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.246578][ T3746] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.246582][ T3746] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.246588][ T3746] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.246591][ T3746] EIP: 0xa7ee1092
[ 37.246593][ T3746] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.246596][ T3746] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   37.246598][ T3746] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   37.246599][ T3746] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   37.265704][ T3747] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3747
[ 37.266337][ T3747] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.266771][ T3747] CPU: 1 UID: 0 PID: 3747 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.266776][ T3747] Call Trace:
[ 37.266781][ T3747] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.266787][ T3747] dump_stack (lib/dump_stack.c:130) 
[ 37.266792][ T3747] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.266800][ T3747] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.266804][ T3747] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.266822][ T3747] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.266825][ T3747] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.266830][ T3747] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.266842][ T3747] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.266846][ T3747] ? __lock_release+0xb1/0x167 
[ 37.266849][ T3747] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.266856][ T3747] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.266859][ T3747] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.266873][ T3747] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.266884][ T3747] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.266890][ T3747] do_execveat_common (fs/exec.c:1855) 
[ 37.266898][ T3747] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.266904][ T3747] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.266909][ T3747] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.266915][ T3747] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.266917][ T3747] EIP: 0xa7ee1092
[ 37.266920][ T3747] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.266922][ T3747] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   37.266924][ T3747] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   37.266926][ T3747] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   37.321027][ T3748] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3748
[ 37.322405][ T3748] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.323292][ T3748] CPU: 1 UID: 0 PID: 3748 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.323300][ T3748] Call Trace:
[ 37.323307][ T3748] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.323318][ T3748] dump_stack (lib/dump_stack.c:130) 
[ 37.323326][ T3748] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.323339][ T3748] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.323345][ T3748] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.323376][ T3748] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.323382][ T3748] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.323388][ T3748] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.323408][ T3748] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.323414][ T3748] ? __lock_release+0xb1/0x167 
[ 37.323418][ T3748] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.323430][ T3748] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.323434][ T3748] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.323456][ T3748] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.323473][ T3748] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.323484][ T3748] do_execveat_common (fs/exec.c:1855) 
[ 37.323497][ T3748] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.323508][ T3748] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.323515][ T3748] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.323526][ T3748] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.323529][ T3748] EIP: 0xa7ee1092
[ 37.323535][ T3748] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.323538][ T3748] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   37.323541][ T3748] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   37.323544][ T3748] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   37.689121][ T3755] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/3755
[ 37.690631][ T3755] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.691569][ T3755] CPU: 0 UID: 0 PID: 3755 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.691576][ T3755] Call Trace:
[ 37.691582][ T3755] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.691592][ T3755] dump_stack (lib/dump_stack.c:130) 
[ 37.691599][ T3755] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.691611][ T3755] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.691618][ T3755] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.691646][ T3755] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.691652][ T3755] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.691659][ T3755] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.691680][ T3755] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.691685][ T3755] ? __lock_release+0xb1/0x167 
[ 37.691690][ T3755] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.691701][ T3755] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.691707][ T3755] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.691728][ T3755] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.691745][ T3755] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.691756][ T3755] do_execveat_common (fs/exec.c:1855) 
[ 37.691769][ T3755] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.691780][ T3755] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.691787][ T3755] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.691797][ T3755] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.691801][ T3755] EIP: 0xa7ee0092
[ 37.691806][ T3755] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.691809][ T3755] EAX: ffffffda EBX: 013259c4 ECX: 01324e98 EDX: 013258a4
[   37.691813][ T3755] ESI: 013259c4 EDI: 01324e98 EBP: afa29504 ESP: afa293e4
[   37.691816][ T3755] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   37.692043][ T3756] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/3756
[ 37.748002][ T3756] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.748439][ T3756] CPU: 0 UID: 0 PID: 3756 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.748443][ T3756] Call Trace:
[ 37.748447][ T3756] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.748453][ T3756] dump_stack (lib/dump_stack.c:130) 
[ 37.748458][ T3756] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.748466][ T3756] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.748471][ T3756] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.748489][ T3756] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.748492][ T3756] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.748497][ T3756] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.748509][ T3756] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.748513][ T3756] ? __lock_release+0xb1/0x167 
[ 37.748516][ T3756] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.748523][ T3756] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.748526][ T3756] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.748540][ T3756] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.748551][ T3756] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.748557][ T3756] do_execveat_common (fs/exec.c:1855) 
[ 37.748565][ T3756] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.748572][ T3756] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.748576][ T3756] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.748582][ T3756] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.748585][ T3756] EIP: 0xa7ee0092
[ 37.748588][ T3756] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.748590][ T3756] EAX: ffffffda EBX: 013259f4 ECX: 013258a8 EDX: 013258d4
[   37.748592][ T3756] ESI: 013259f4 EDI: 013258a8 EBP: afa29504 ESP: afa293e4
[   37.748594][ T3756] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   37.859292][ T3775] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/3775
[ 37.860031][ T3775] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   37.860475][ T3775] CPU: 0 UID: 0 PID: 3775 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   37.860480][ T3775] Call Trace:
[ 37.860483][ T3775] dump_stack_lvl (lib/dump_stack.c:123) 
[ 37.860490][ T3775] dump_stack (lib/dump_stack.c:130) 
[ 37.860495][ T3775] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 37.860503][ T3775] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 37.860507][ T3775] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.860525][ T3775] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 37.860528][ T3775] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 37.860532][ T3775] ? elf_read (fs/binfmt_elf.c:470) 
[ 37.860545][ T3775] load_elf_binary (fs/binfmt_elf.c:996) 
[ 37.860548][ T3775] ? __lock_release+0xb1/0x167 
[ 37.860551][ T3775] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.860558][ T3775] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.860561][ T3775] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 37.860575][ T3775] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 37.860585][ T3775] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 37.860592][ T3775] do_execveat_common (fs/exec.c:1855) 
[ 37.860599][ T3775] __ia32_sys_execve (fs/exec.c:2000) 
[ 37.860606][ T3775] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 37.860610][ T3775] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 37.860616][ T3775] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   37.860619][ T3775] EIP: 0xa7ee0092
[ 37.860622][ T3775] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   37.860623][ T3775] EAX: ffffffda EBX: 01324e94 ECX: 01324ef8 EDX: 013258a4
[   37.860626][ T3775] ESI: 01324e94 EDI: 01324ef8 EBP: 01324e94 ESP: afa293d4
[   37.860627][ T3775] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   38.327912][ T3795] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3795
[ 38.329481][ T3795] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   38.330395][ T3795] CPU: 1 UID: 0 PID: 3795 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   38.330403][ T3795] Call Trace:
[ 38.330411][ T3795] dump_stack_lvl (lib/dump_stack.c:123) 
[ 38.330423][ T3795] dump_stack (lib/dump_stack.c:130) 
[ 38.330431][ T3795] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 38.330444][ T3795] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 38.330450][ T3795] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.330480][ T3795] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.330486][ T3795] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 38.330494][ T3795] ? elf_read (fs/binfmt_elf.c:470) 
[ 38.330515][ T3795] load_elf_binary (fs/binfmt_elf.c:996) 
[ 38.330522][ T3795] ? __lock_release+0xb1/0x167 
[ 38.330527][ T3795] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.330539][ T3795] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.330543][ T3795] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 38.330566][ T3795] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.330586][ T3795] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 38.330597][ T3795] do_execveat_common (fs/exec.c:1855) 
[ 38.330609][ T3795] __ia32_sys_execve (fs/exec.c:2000) 
[ 38.330620][ T3795] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 38.330627][ T3795] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 38.330638][ T3795] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   38.330642][ T3795] EIP: 0xa7ee1092
[ 38.330648][ T3795] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   38.330652][ T3795] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   38.330655][ T3795] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   38.330658][ T3795] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   38.355045][ T3796] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3796
[ 38.356939][ T3796] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   38.358165][ T3796] CPU: 1 UID: 0 PID: 3796 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   38.358170][ T3796] Call Trace:
[ 38.358177][ T3796] dump_stack_lvl (lib/dump_stack.c:123) 
[ 38.358185][ T3796] dump_stack (lib/dump_stack.c:130) 
[ 38.358190][ T3796] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 38.358198][ T3796] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 38.358202][ T3796] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.358221][ T3796] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.358224][ T3796] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 38.358230][ T3796] ? elf_read (fs/binfmt_elf.c:470) 
[ 38.358243][ T3796] load_elf_binary (fs/binfmt_elf.c:996) 
[ 38.358247][ T3796] ? __lock_release+0xb1/0x167 
[ 38.358251][ T3796] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.358258][ T3796] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.358261][ T3796] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 38.358275][ T3796] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.358286][ T3796] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 38.358293][ T3796] do_execveat_common (fs/exec.c:1855) 
[ 38.358301][ T3796] __ia32_sys_execve (fs/exec.c:2000) 
[ 38.358308][ T3796] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 38.358312][ T3796] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 38.358319][ T3796] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   38.358322][ T3796] EIP: 0xa7ee1092
[ 38.358325][ T3796] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   38.358328][ T3796] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   38.358330][ T3796] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   38.358332][ T3796] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   38.410990][ T3797] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3797
[ 38.417896][ T3797] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   38.420620][ T3797] CPU: 1 UID: 0 PID: 3797 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   38.420629][ T3797] Call Trace:
[ 38.420638][ T3797] dump_stack_lvl (lib/dump_stack.c:123) 
[ 38.420649][ T3797] dump_stack (lib/dump_stack.c:130) 
[ 38.420656][ T3797] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 38.420669][ T3797] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 38.420675][ T3797] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.420705][ T3797] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 38.420710][ T3797] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 38.420718][ T3797] ? elf_read (fs/binfmt_elf.c:470) 
[ 38.420739][ T3797] load_elf_binary (fs/binfmt_elf.c:996) 
[ 38.420746][ T3797] ? __lock_release+0xb1/0x167 
[ 38.420752][ T3797] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.420763][ T3797] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.420768][ T3797] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 38.420791][ T3797] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 38.420808][ T3797] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 38.420820][ T3797] do_execveat_common (fs/exec.c:1855) 
[ 38.420832][ T3797] __ia32_sys_execve (fs/exec.c:2000) 
[ 38.420843][ T3797] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 38.420851][ T3797] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 38.420862][ T3797] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   38.420866][ T3797] EIP: 0xa7ee1092
[ 38.420872][ T3797] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   38.420875][ T3797] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   38.420879][ T3797] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   38.420882][ T3797] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   39.462916][ T3820] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3820
[ 39.463622][ T3820] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   39.464056][ T3820] CPU: 1 UID: 0 PID: 3820 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   39.464061][ T3820] Call Trace:
[ 39.464065][ T3820] dump_stack_lvl (lib/dump_stack.c:123) 
[ 39.464072][ T3820] dump_stack (lib/dump_stack.c:130) 
[ 39.464077][ T3820] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 39.464085][ T3820] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 39.464089][ T3820] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 39.464107][ T3820] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 39.464110][ T3820] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 39.464115][ T3820] ? elf_read (fs/binfmt_elf.c:470) 
[ 39.464127][ T3820] load_elf_binary (fs/binfmt_elf.c:996) 
[ 39.464131][ T3820] ? __lock_release+0xb1/0x167 
[ 39.464134][ T3820] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 39.464141][ T3820] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 39.464144][ T3820] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 39.464158][ T3820] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 39.464169][ T3820] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 39.464176][ T3820] do_execveat_common (fs/exec.c:1855) 
[ 39.464183][ T3820] __ia32_sys_execve (fs/exec.c:2000) 
[ 39.464190][ T3820] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 39.464194][ T3820] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 39.464200][ T3820] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   39.464203][ T3820] EIP: 0xa7ee1092
[ 39.464206][ T3820] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   39.464208][ T3820] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   39.464210][ T3820] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   39.464212][ T3820] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   40.315276][  T212] LKP: stdout: 193:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-203/trinity-group-03-5-300s-debian-11.1-i386-20220923.cgz-i386-randconfig-003-20250720-631f4b8aed51-20250721-330534-12j8wos-1.yaml
[   40.315297][  T212]
[   40.328391][  T212] RESULT_ROOT=/result/trinity/group-03-5-300s/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-003-20250720/gcc-12/631f4b8aed514ab146135624d28f2fca0a08f731/0
[   40.328411][  T212]
[   40.338741][  T212] job=/lkp/jobs/scheduled/vm-meta-203/trinity-group-03-5-300s-debian-11.1-i386-20220923.cgz-i386-randconfig-003-20250720-631f4b8aed51-20250721-330534-12j8wos-1.yaml
[   40.338753][  T212]
[   42.555148][ T3936] check_preemption_disabled: 8 callbacks suppressed
[   42.555156][ T3936] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3936
[ 42.557182][ T3936] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   42.557856][ T3936] CPU: 0 UID: 0 PID: 3936 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   42.557863][ T3936] Call Trace:
[ 42.557868][ T3936] dump_stack_lvl (lib/dump_stack.c:123) 
[ 42.557877][ T3936] dump_stack (lib/dump_stack.c:130) 
[ 42.557884][ T3936] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 42.557897][ T3936] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 42.557903][ T3936] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.557935][ T3936] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.557940][ T3936] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 42.557947][ T3936] ? elf_read (fs/binfmt_elf.c:470) 
[ 42.557969][ T3936] load_elf_binary (fs/binfmt_elf.c:996) 
[ 42.557974][ T3936] ? __lock_release+0xb1/0x167 
[ 42.557979][ T3936] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.557991][ T3936] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.557995][ T3936] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 42.558019][ T3936] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.558039][ T3936] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 42.558051][ T3936] do_execveat_common (fs/exec.c:1855) 
[ 42.558064][ T3936] __ia32_sys_execve (fs/exec.c:2000) 
[ 42.558075][ T3936] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 42.558082][ T3936] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 42.558092][ T3936] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   42.558096][ T3936] EIP: 0xa7ee1092
[ 42.558100][ T3936] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   42.558103][ T3936] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   42.558106][ T3936] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   42.558109][ T3936] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   42.596361][ T3937] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3937
[ 42.597365][ T3937] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   42.598044][ T3937] CPU: 0 UID: 0 PID: 3937 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   42.598051][ T3937] Call Trace:
[ 42.598058][ T3937] dump_stack_lvl (lib/dump_stack.c:123) 
[ 42.598066][ T3937] dump_stack (lib/dump_stack.c:130) 
[ 42.598074][ T3937] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 42.598087][ T3937] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 42.598093][ T3937] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.598126][ T3937] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.598131][ T3937] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 42.598137][ T3937] ? elf_read (fs/binfmt_elf.c:470) 
[ 42.598159][ T3937] load_elf_binary (fs/binfmt_elf.c:996) 
[ 42.598165][ T3937] ? __lock_release+0xb1/0x167 
[ 42.598169][ T3937] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.598181][ T3937] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.598186][ T3937] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 42.598211][ T3937] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.598230][ T3937] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 42.598242][ T3937] do_execveat_common (fs/exec.c:1855) 
[ 42.598255][ T3937] __ia32_sys_execve (fs/exec.c:2000) 
[ 42.598267][ T3937] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 42.598273][ T3937] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 42.598284][ T3937] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   42.598287][ T3937] EIP: 0xa7ee1092
[ 42.598292][ T3937] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   42.598295][ T3937] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   42.598298][ T3937] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   42.598301][ T3937] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   42.647122][ T3938] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3938
[ 42.648095][ T3938] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   42.648768][ T3938] CPU: 0 UID: 0 PID: 3938 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   42.648774][ T3938] Call Trace:
[ 42.648791][ T3938] dump_stack_lvl (lib/dump_stack.c:123) 
[ 42.648800][ T3938] dump_stack (lib/dump_stack.c:130) 
[ 42.648808][ T3938] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 42.648821][ T3938] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 42.648827][ T3938] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.648859][ T3938] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 42.648865][ T3938] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 42.648872][ T3938] ? elf_read (fs/binfmt_elf.c:470) 
[ 42.648894][ T3938] load_elf_binary (fs/binfmt_elf.c:996) 
[ 42.648899][ T3938] ? __lock_release+0xb1/0x167 
[ 42.648904][ T3938] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.648915][ T3938] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.648920][ T3938] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 42.648944][ T3938] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 42.648964][ T3938] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 42.648975][ T3938] do_execveat_common (fs/exec.c:1855) 
[ 42.648989][ T3938] __ia32_sys_execve (fs/exec.c:2000) 
[ 42.649000][ T3938] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 42.649007][ T3938] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 42.649017][ T3938] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   42.649021][ T3938] EIP: 0xa7ee1092
[ 42.649025][ T3938] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   42.649028][ T3938] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   42.649031][ T3938] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   42.649034][ T3938] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   43.692784][ T3953] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3953
[ 43.694035][ T3953] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   43.694818][ T3953] CPU: 0 UID: 0 PID: 3953 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   43.694825][ T3953] Call Trace:
[ 43.694831][ T3953] dump_stack_lvl (lib/dump_stack.c:123) 
[ 43.694840][ T3953] dump_stack (lib/dump_stack.c:130) 
[ 43.694848][ T3953] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 43.694860][ T3953] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 43.694866][ T3953] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.694895][ T3953] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.694899][ T3953] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 43.694906][ T3953] ? elf_read (fs/binfmt_elf.c:470) 
[ 43.694926][ T3953] load_elf_binary (fs/binfmt_elf.c:996) 
[ 43.694931][ T3953] ? __lock_release+0xb1/0x167 
[ 43.694936][ T3953] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.694947][ T3953] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.694952][ T3953] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 43.694974][ T3953] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.694991][ T3953] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 43.695002][ T3953] do_execveat_common (fs/exec.c:1855) 
[ 43.695014][ T3953] __ia32_sys_execve (fs/exec.c:2000) 
[ 43.695025][ T3953] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 43.695031][ T3953] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 43.695041][ T3953] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   43.695044][ T3953] EIP: 0xa7ee1092
[ 43.695050][ T3953] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   43.695053][ T3953] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   43.695056][ T3953] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   43.695059][ T3953] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   43.737267][ T3954] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3954
[ 43.738536][ T3954] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   43.739518][ T3954] CPU: 0 UID: 0 PID: 3954 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   43.739526][ T3954] Call Trace:
[ 43.739533][ T3954] dump_stack_lvl (lib/dump_stack.c:123) 
[ 43.739543][ T3954] dump_stack (lib/dump_stack.c:130) 
[ 43.739551][ T3954] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 43.739564][ T3954] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 43.739570][ T3954] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.739601][ T3954] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.739606][ T3954] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 43.739613][ T3954] ? elf_read (fs/binfmt_elf.c:470) 
[ 43.739635][ T3954] load_elf_binary (fs/binfmt_elf.c:996) 
[ 43.739641][ T3954] ? __lock_release+0xb1/0x167 
[ 43.739645][ T3954] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.739657][ T3954] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.739663][ T3954] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 43.739685][ T3954] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.739703][ T3954] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 43.739714][ T3954] do_execveat_common (fs/exec.c:1855) 
[ 43.739727][ T3954] __ia32_sys_execve (fs/exec.c:2000) 
[ 43.739738][ T3954] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 43.739745][ T3954] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 43.739756][ T3954] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   43.739759][ T3954] EIP: 0xa7ee1092
[ 43.739764][ T3954] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   43.739768][ T3954] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   43.739771][ T3954] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   43.739774][ T3954] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   43.787289][ T3957] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3957
[ 43.788459][ T3957] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   43.791856][ T3957] CPU: 1 UID: 0 PID: 3957 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   43.791864][ T3957] Call Trace:
[ 43.791871][ T3957] dump_stack_lvl (lib/dump_stack.c:123) 
[ 43.791882][ T3957] dump_stack (lib/dump_stack.c:130) 
[ 43.791889][ T3957] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 43.791904][ T3957] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 43.791910][ T3957] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.791938][ T3957] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 43.791942][ T3957] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 43.791949][ T3957] ? elf_read (fs/binfmt_elf.c:470) 
[ 43.791968][ T3957] load_elf_binary (fs/binfmt_elf.c:996) 
[ 43.791973][ T3957] ? __lock_release+0xb1/0x167 
[ 43.791978][ T3957] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.791989][ T3957] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.791994][ T3957] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 43.792016][ T3957] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 43.792040][ T3957] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 43.792050][ T3957] do_execveat_common (fs/exec.c:1855) 
[ 43.792063][ T3957] __ia32_sys_execve (fs/exec.c:2000) 
[ 43.792074][ T3957] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 43.792080][ T3957] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 43.792090][ T3957] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   43.792093][ T3957] EIP: 0xa7ee1092
[ 43.792099][ T3957] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   43.792102][ T3957] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   43.792105][ T3957] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   43.792108][ T3957] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   44.157552][  T212] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/trinity/group-03-5-300s/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-003-20250720/gcc-12/631f4b8aed514ab146135624d28f2fca0a08f731/0, TMP_RESULT_ROOT: /tmp/lkp/result
[   44.157565][  T212]
[   44.166124][  T212] run-job /lkp/jobs/scheduled/vm-meta-203/trinity-group-03-5-300s-debian-11.1-i386-20220923.cgz-i386-randconfig-003-20250720-631f4b8aed51-20250721-330534-12j8wos-1.yaml
[   44.166135][  T212]
[   44.892994][ T3989] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3989
[ 44.894494][ T3989] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   44.895449][ T3989] CPU: 0 UID: 0 PID: 3989 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   44.895456][ T3989] Call Trace:
[ 44.895462][ T3989] dump_stack_lvl (lib/dump_stack.c:123) 
[ 44.895472][ T3989] dump_stack (lib/dump_stack.c:130) 
[ 44.895480][ T3989] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 44.895492][ T3989] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 44.895499][ T3989] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 44.895532][ T3989] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 44.895537][ T3989] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 44.895545][ T3989] ? elf_read (fs/binfmt_elf.c:470) 
[ 44.895564][ T3989] load_elf_binary (fs/binfmt_elf.c:996) 
[ 44.895570][ T3989] ? __lock_release+0xb1/0x167 
[ 44.895575][ T3989] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.895586][ T3989] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.895591][ T3989] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 44.895613][ T3989] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.895631][ T3989] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 44.895642][ T3989] do_execveat_common (fs/exec.c:1855) 
[ 44.895655][ T3989] __ia32_sys_execve (fs/exec.c:2000) 
[ 44.895666][ T3989] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 44.895672][ T3989] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 44.895682][ T3989] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   44.895686][ T3989] EIP: 0xa7ee1092
[ 44.895691][ T3989] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   44.895695][ T3989] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   44.895698][ T3989] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   44.895701][ T3989] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   44.965896][ T3994] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3994
[ 44.966576][ T3994] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   44.967017][ T3994] CPU: 0 UID: 0 PID: 3994 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   44.967022][ T3994] Call Trace:
[ 44.967026][ T3994] dump_stack_lvl (lib/dump_stack.c:123) 
[ 44.967033][ T3994] dump_stack (lib/dump_stack.c:130) 
[ 44.967038][ T3994] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 44.967046][ T3994] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 44.967050][ T3994] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 44.967069][ T3994] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 44.967134][ T3994] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 44.967140][ T3994] ? elf_read (fs/binfmt_elf.c:470) 
[ 44.967159][ T3994] load_elf_binary (fs/binfmt_elf.c:996) 
[ 44.967165][ T3994] ? __lock_release+0xb1/0x167 
[ 44.967170][ T3994] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.967180][ T3994] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.967185][ T3994] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 44.967207][ T3994] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 44.967224][ T3994] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 44.967234][ T3994] do_execveat_common (fs/exec.c:1855) 
[ 44.967246][ T3994] __ia32_sys_execve (fs/exec.c:2000) 
[ 44.967257][ T3994] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 44.967263][ T3994] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 44.967273][ T3994] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   44.967276][ T3994] EIP: 0xa7ee1092
[ 44.967281][ T3994] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   44.967284][ T3994] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   44.967288][ T3994] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   44.967290][ T3994] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   45.009402][ T3995] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3995
[ 45.025738][ T3995] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   45.026189][ T3995] CPU: 0 UID: 0 PID: 3995 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   45.026193][ T3995] Call Trace:
[ 45.026198][ T3995] dump_stack_lvl (lib/dump_stack.c:123) 
[ 45.026205][ T3995] dump_stack (lib/dump_stack.c:130) 
[ 45.026211][ T3995] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 45.026219][ T3995] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 45.026223][ T3995] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 45.026242][ T3995] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 45.026244][ T3995] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 45.026249][ T3995] ? elf_read (fs/binfmt_elf.c:470) 
[ 45.026262][ T3995] load_elf_binary (fs/binfmt_elf.c:996) 
[ 45.026265][ T3995] ? __lock_release+0xb1/0x167 
[ 45.026268][ T3995] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 45.026275][ T3995] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 45.026278][ T3995] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 45.026292][ T3995] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 45.026303][ T3995] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 45.026310][ T3995] do_execveat_common (fs/exec.c:1855) 
[ 45.026317][ T3995] __ia32_sys_execve (fs/exec.c:2000) 
[ 45.026324][ T3995] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 45.026329][ T3995] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 45.026336][ T3995] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   45.026338][ T3995] EIP: 0xa7ee1092
[ 45.026342][ T3995] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   45.026344][ T3995] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   45.026346][ T3995] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   45.026348][ T3995] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   45.639878][  T212] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-203/trinity-group-03-5-300s-debian-11.1-i386-20220923.cgz-i386-randconfig-003-20250720-631f4b8aed51-20250721-330534-12j8wos-1.yaml&job_state=running -O /dev/null
[   45.639892][  T212]
[   45.643039][  T212] target ucode:
[   45.643047][  T212]
[   45.644381][  T212] check_nr_cpu
[   45.644387][  T212]
[   45.647128][  T212] CPU(s):                                  2
[   45.647136][  T212]
[   45.649271][  T212] On-line CPU(s) list:                     0,1
[   45.649278][  T212]
[   45.651339][  T212] Thread(s) per core:                      1
[   45.651346][  T212]
[   45.653662][  T212] Core(s) per socket:                      1
[   45.653670][  T212]
[   45.655478][  T212] Socket(s):                               2
[   45.655484][  T212]
[   45.659986][  T212] Seeding trinity by 2817034979 based on vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-003-20250720
[   45.659997][  T212]
[   45.662517][  T212] groupadd: group 'nogroup' already exists
[   45.662524][  T212]
[   46.067150][ T4017] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/4017
[ 46.068437][ T4017] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   46.069372][ T4017] CPU: 0 UID: 0 PID: 4017 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   46.069380][ T4017] Call Trace:
[ 46.069387][ T4017] dump_stack_lvl (lib/dump_stack.c:123) 
[ 46.069396][ T4017] dump_stack (lib/dump_stack.c:130) 
[ 46.069403][ T4017] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 46.069416][ T4017] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 46.069422][ T4017] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 46.069450][ T4017] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 46.069455][ T4017] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 46.069462][ T4017] ? elf_read (fs/binfmt_elf.c:470) 
[ 46.069481][ T4017] load_elf_binary (fs/binfmt_elf.c:996) 
[ 46.069487][ T4017] ? __lock_release+0xb1/0x167 
[ 46.069492][ T4017] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 46.069502][ T4017] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 46.069507][ T4017] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 46.069529][ T4017] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 46.069546][ T4017] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 46.069556][ T4017] do_execveat_common (fs/exec.c:1855) 
[ 46.069568][ T4017] __ia32_sys_execve (fs/exec.c:2000) 
[ 46.069579][ T4017] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 46.069585][ T4017] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 46.069595][ T4017] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   46.069599][ T4017] EIP: 0xa7ee1092
[ 46.069605][ T4017] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   46.069608][ T4017] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   46.069611][ T4017] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   46.069614][ T4017] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   48.207344][ T4066] check_preemption_disabled: 5 callbacks suppressed
[   48.207361][ T4066] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/4066
[ 48.210018][ T4066] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   48.210976][ T4066] CPU: 1 UID: 0 PID: 4066 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   48.210983][ T4066] Call Trace:
[ 48.210989][ T4066] dump_stack_lvl (lib/dump_stack.c:123) 
[ 48.210999][ T4066] dump_stack (lib/dump_stack.c:130) 
[ 48.211006][ T4066] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 48.211019][ T4066] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 48.211026][ T4066] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.211055][ T4066] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.211061][ T4066] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 48.211068][ T4066] ? elf_read (fs/binfmt_elf.c:470) 
[ 48.211088][ T4066] load_elf_binary (fs/binfmt_elf.c:996) 
[ 48.211094][ T4066] ? __lock_release+0xb1/0x167 
[ 48.211099][ T4066] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.211109][ T4066] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.211115][ T4066] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 48.211137][ T4066] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.211155][ T4066] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 48.211167][ T4066] do_execveat_common (fs/exec.c:1855) 
[ 48.211180][ T4066] __ia32_sys_execve (fs/exec.c:2000) 
[ 48.211191][ T4066] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 48.211197][ T4066] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 48.211208][ T4066] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   48.211212][ T4066] EIP: 0xa7ee1092
[ 48.211216][ T4066] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   48.211220][ T4066] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   48.211223][ T4066] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   48.211226][ T4066] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   48.258468][ T4076] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/4076
[ 48.259199][ T4076] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   48.259639][ T4076] CPU: 1 UID: 0 PID: 4076 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   48.259644][ T4076] Call Trace:
[ 48.259648][ T4076] dump_stack_lvl (lib/dump_stack.c:123) 
[ 48.259655][ T4076] dump_stack (lib/dump_stack.c:130) 
[ 48.259660][ T4076] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 48.259668][ T4076] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 48.259672][ T4076] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.259690][ T4076] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.259693][ T4076] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 48.259698][ T4076] ? elf_read (fs/binfmt_elf.c:470) 
[ 48.259710][ T4076] load_elf_binary (fs/binfmt_elf.c:996) 
[ 48.259714][ T4076] ? __lock_release+0xb1/0x167 
[ 48.259717][ T4076] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.259724][ T4076] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.259727][ T4076] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 48.259741][ T4076] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.259752][ T4076] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 48.259758][ T4076] do_execveat_common (fs/exec.c:1855) 
[ 48.259766][ T4076] __ia32_sys_execve (fs/exec.c:2000) 
[ 48.259772][ T4076] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 48.259777][ T4076] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 48.259783][ T4076] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   48.259786][ T4076] EIP: 0xa7ee1092
[ 48.259788][ T4076] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   48.259790][ T4076] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   48.259793][ T4076] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   48.259794][ T4076] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   48.346789][ T4080] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/4080
[ 48.347439][ T4080] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   48.347873][ T4080] CPU: 1 UID: 0 PID: 4080 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   48.347878][ T4080] Call Trace:
[ 48.347881][ T4080] dump_stack_lvl (lib/dump_stack.c:123) 
[ 48.347888][ T4080] dump_stack (lib/dump_stack.c:130) 
[ 48.347893][ T4080] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 48.347901][ T4080] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 48.347905][ T4080] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.347924][ T4080] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.347926][ T4080] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 48.347931][ T4080] ? elf_read (fs/binfmt_elf.c:470) 
[ 48.347943][ T4080] load_elf_binary (fs/binfmt_elf.c:996) 
[ 48.347947][ T4080] ? __lock_release+0xb1/0x167 
[ 48.347950][ T4080] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.347957][ T4080] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.347960][ T4080] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 48.347974][ T4080] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.347985][ T4080] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 48.347992][ T4080] do_execveat_common (fs/exec.c:1855) 
[ 48.348000][ T4080] __ia32_sys_execve (fs/exec.c:2000) 
[ 48.348006][ T4080] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 48.348010][ T4080] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 48.348017][ T4080] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   48.348019][ T4080] EIP: 0xa7ee1092
[ 48.348022][ T4080] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   48.348024][ T4080] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   48.348026][ T4080] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   48.348028][ T4080] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   48.928211][  T328] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/328
[ 48.929704][ T328] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   48.930622][  T328] CPU: 1 UID: 0 PID: 328 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   48.930630][  T328] Call Trace:
[ 48.930637][ T328] dump_stack_lvl (lib/dump_stack.c:123) 
[ 48.930646][ T328] dump_stack (lib/dump_stack.c:130) 
[ 48.930653][ T328] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 48.930665][ T328] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 48.930672][ T328] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.930702][ T328] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.930707][ T328] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 48.930714][ T328] ? elf_read (fs/binfmt_elf.c:470) 
[ 48.930734][ T328] load_elf_binary (fs/binfmt_elf.c:996) 
[ 48.930740][ T328] ? __lock_release+0xb1/0x167 
[ 48.930745][ T328] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.930755][ T328] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.930760][ T328] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 48.930782][ T328] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.930801][ T328] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 48.930812][ T328] do_execveat_common (fs/exec.c:1855) 
[ 48.930825][ T328] __ia32_sys_execve (fs/exec.c:2000) 
[ 48.930836][ T328] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 48.930843][ T328] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 48.930853][ T328] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   48.930857][  T328] EIP: 0xa7ee0092
[ 48.930861][ T328] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   48.930865][  T328] EAX: ffffffda EBX: 013259c4 ECX: 01324e98 EDX: 013258a4
[   48.930868][  T328] ESI: 013259c4 EDI: 01324e98 EBP: afa29504 ESP: afa293e4
[   48.930872][  T328] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   48.959043][  T330] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/330
[ 48.960479][ T330] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   48.961464][  T330] CPU: 1 UID: 0 PID: 330 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   48.961469][  T330] Call Trace:
[ 48.961473][ T330] dump_stack_lvl (lib/dump_stack.c:123) 
[ 48.961480][ T330] dump_stack (lib/dump_stack.c:130) 
[ 48.961485][ T330] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 48.961493][ T330] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 48.961498][ T330] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.961515][ T330] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 48.961518][ T330] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 48.961523][ T330] ? elf_read (fs/binfmt_elf.c:470) 
[ 48.961535][ T330] load_elf_binary (fs/binfmt_elf.c:996) 
[ 48.961538][ T330] ? __lock_release+0xb1/0x167 
[ 48.961542][ T330] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.961548][ T330] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.961551][ T330] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 48.961565][ T330] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 48.961576][ T330] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 48.961583][ T330] do_execveat_common (fs/exec.c:1855) 
[ 48.961590][ T330] __ia32_sys_execve (fs/exec.c:2000) 
[ 48.961597][ T330] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 48.961601][ T330] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 48.961607][ T330] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   48.961609][  T330] EIP: 0xa7ee0092
[ 48.961612][ T330] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   48.961614][  T330] EAX: ffffffda EBX: 013259f4 ECX: 013258a8 EDX: 013258d4
[   48.961616][  T330] ESI: 013259f4 EDI: 013258a8 EBP: afa29504 ESP: afa293e4
[   48.961618][  T330] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   49.034505][  T331] BUG: using smp_processor_id() in preemptible [00000000] code: oom-killer/331
[ 49.036328][ T331] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   49.037831][  T331] CPU: 1 UID: 0 PID: 331 Comm: oom-killer Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   49.037838][  T331] Call Trace:
[ 49.037844][ T331] dump_stack_lvl (lib/dump_stack.c:123) 
[ 49.037854][ T331] dump_stack (lib/dump_stack.c:130) 
[ 49.037861][ T331] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 49.037875][ T331] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 49.037882][ T331] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.037911][ T331] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.037916][ T331] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 49.037922][ T331] ? elf_read (fs/binfmt_elf.c:470) 
[ 49.037943][ T331] load_elf_binary (fs/binfmt_elf.c:996) 
[ 49.037948][ T331] ? __lock_release+0xb1/0x167 
[ 49.037953][ T331] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.037964][ T331] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.037968][ T331] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 49.037990][ T331] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.038008][ T331] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 49.038019][ T331] do_execveat_common (fs/exec.c:1855) 
[ 49.038031][ T331] __ia32_sys_execve (fs/exec.c:2000) 
[ 49.038042][ T331] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 49.038049][ T331] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 49.038061][ T331] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   49.038065][  T331] EIP: 0xa7ee0092
[ 49.038070][ T331] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   49.038073][  T331] EAX: ffffffda EBX: 01324e94 ECX: 01324ef8 EDX: 013258a4
[   49.038076][  T331] ESI: 01324e94 EDI: 01324ef8 EBP: 01324e94 ESP: afa293d4
[   49.038079][  T331] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   49.412519][  T340] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/340
[ 49.413932][ T340] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   49.414847][  T340] CPU: 1 UID: 0 PID: 340 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   49.414854][  T340] Call Trace:
[ 49.414861][ T340] dump_stack_lvl (lib/dump_stack.c:123) 
[ 49.414870][ T340] dump_stack (lib/dump_stack.c:130) 
[ 49.414878][ T340] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 49.414891][ T340] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 49.414898][ T340] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.414927][ T340] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.414933][ T340] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 49.414939][ T340] ? elf_read (fs/binfmt_elf.c:470) 
[ 49.414960][ T340] load_elf_binary (fs/binfmt_elf.c:996) 
[ 49.414965][ T340] ? __lock_release+0xb1/0x167 
[ 49.414970][ T340] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.414981][ T340] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.414986][ T340] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 49.415008][ T340] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.415027][ T340] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 49.415038][ T340] do_execveat_common (fs/exec.c:1855) 
[ 49.415050][ T340] __ia32_sys_execve (fs/exec.c:2000) 
[ 49.415062][ T340] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 49.415069][ T340] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 49.415079][ T340] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   49.415082][  T340] EIP: 0xa7ee1092
[ 49.415087][ T340] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   49.415091][  T340] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   49.415094][  T340] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   49.415097][  T340] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   49.460622][  T347] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/347
[ 49.461899][ T347] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   49.462790][  T347] CPU: 1 UID: 0 PID: 347 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   49.462794][  T347] Call Trace:
[ 49.462799][ T347] dump_stack_lvl (lib/dump_stack.c:123) 
[ 49.462805][ T347] dump_stack (lib/dump_stack.c:130) 
[ 49.462810][ T347] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 49.462819][ T347] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 49.462823][ T347] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.462841][ T347] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.462844][ T347] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 49.462848][ T347] ? elf_read (fs/binfmt_elf.c:470) 
[ 49.462861][ T347] load_elf_binary (fs/binfmt_elf.c:996) 
[ 49.462864][ T347] ? __lock_release+0xb1/0x167 
[ 49.462867][ T347] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.462874][ T347] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.462877][ T347] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 49.462891][ T347] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.462902][ T347] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 49.462908][ T347] do_execveat_common (fs/exec.c:1855) 
[ 49.462916][ T347] __ia32_sys_execve (fs/exec.c:2000) 
[ 49.462923][ T347] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 49.462927][ T347] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 49.462933][ T347] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   49.462935][  T347] EIP: 0xa7ee1092
[ 49.462938][ T347] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   49.462940][  T347] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   49.462942][  T347] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   49.462944][  T347] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   49.505294][  T351] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/351
[ 49.506713][ T351] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   49.507602][  T351] CPU: 1 UID: 0 PID: 351 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   49.507610][  T351] Call Trace:
[ 49.507616][ T351] dump_stack_lvl (lib/dump_stack.c:123) 
[ 49.507625][ T351] dump_stack (lib/dump_stack.c:130) 
[ 49.507633][ T351] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 49.507645][ T351] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 49.507652][ T351] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.507680][ T351] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 49.507686][ T351] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 49.507693][ T351] ? elf_read (fs/binfmt_elf.c:470) 
[ 49.507714][ T351] load_elf_binary (fs/binfmt_elf.c:996) 
[ 49.507719][ T351] ? __lock_release+0xb1/0x167 
[ 49.507724][ T351] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.507735][ T351] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.507740][ T351] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 49.507762][ T351] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 49.507782][ T351] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 49.507793][ T351] do_execveat_common (fs/exec.c:1855) 
[ 49.507806][ T351] __ia32_sys_execve (fs/exec.c:2000) 
[ 49.507818][ T351] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 49.507825][ T351] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 49.507835][ T351] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   49.507839][  T351] EIP: 0xa7ee1092
[ 49.507844][ T351] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   49.507847][  T351] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   49.507851][  T351] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   49.507854][  T351] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   50.543465][  T376] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/376
[ 50.544188][ T376] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   50.544642][  T376] CPU: 0 UID: 0 PID: 376 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   50.544647][  T376] Call Trace:
[ 50.544652][ T376] dump_stack_lvl (lib/dump_stack.c:123) 
[ 50.544658][ T376] dump_stack (lib/dump_stack.c:130) 
[ 50.544663][ T376] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 50.544672][ T376] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 50.544676][ T376] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 50.544694][ T376] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 50.544697][ T376] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 50.544701][ T376] ? elf_read (fs/binfmt_elf.c:470) 
[ 50.544714][ T376] load_elf_binary (fs/binfmt_elf.c:996) 
[ 50.544717][ T376] ? __lock_release+0xb1/0x167 
[ 50.544720][ T376] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 50.544727][ T376] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 50.544730][ T376] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 50.544744][ T376] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 50.544754][ T376] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 50.544761][ T376] do_execveat_common (fs/exec.c:1855) 
[ 50.544769][ T376] __ia32_sys_execve (fs/exec.c:2000) 
[ 50.544775][ T376] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 50.544779][ T376] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 50.544785][ T376] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   50.544788][  T376] EIP: 0xa7ee1092
[ 50.544790][ T376] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   50.544792][  T376] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   50.544794][  T376] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   50.544796][  T376] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   53.160745][  T212] 2025-07-20 19:18:45 chroot --userspec nobody:nogroup / trinity -q -q -l off -s 2817034979 -N 999999999 -c capset -c clock_adjtime -c creat -c epoll_wait -c execve -c fchownat -c fgetxattr -c fspick -c fstatat64 -c get_mempolicy -c getgroups -c getresgid -c getuid16 -c getxattr -c io_destroy -c io_getevents -c io_uring_enter -c ioctl -c iopl -c listen -c mbind -c migrate_pages -c mkdirat -c mlockall -c mmap -c mmap2 -c mq_getsetattr -c mq_timedsend -c munlockall -c oldumount -c pause -c pidfd_open -c pipe2 -c pkey_mprotect -c ppoll -c prctl -c ptrace -c read -c request_key -c rmdir -c sched_getparam -c sched_setparam -c semtimedop -c sendfile -c sendto -c setfsgid -c setfsuid16 -c setgroups -c setitimer -c setregid16 -c setsid -c shutdown -c sigaltstack -c sync -c sysfs -c syslog -c timerfd_create -c truncate -c truncate64 -c umask -c userfaultfd -c vm86old -c vmsplice -c waitid
[   53.160765][  T212]
[   53.661831][  T512] check_preemption_disabled: 8 callbacks suppressed
[   53.661838][  T512] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/512
[ 53.664493][ T512] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   53.664929][  T512] CPU: 0 UID: 0 PID: 512 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   53.664934][  T512] Call Trace:
[ 53.664939][ T512] dump_stack_lvl (lib/dump_stack.c:123) 
[ 53.664945][ T512] dump_stack (lib/dump_stack.c:130) 
[ 53.664950][ T512] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 53.664958][ T512] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 53.664963][ T512] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.664981][ T512] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.664983][ T512] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 53.664988][ T512] ? elf_read (fs/binfmt_elf.c:470) 
[ 53.665001][ T512] load_elf_binary (fs/binfmt_elf.c:996) 
[ 53.665004][ T512] ? __lock_release+0xb1/0x167 
[ 53.665007][ T512] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.665014][ T512] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.665017][ T512] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 53.665031][ T512] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.665041][ T512] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 53.665048][ T512] do_execveat_common (fs/exec.c:1855) 
[ 53.665056][ T512] __ia32_sys_execve (fs/exec.c:2000) 
[ 53.665063][ T512] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 53.665067][ T512] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 53.665074][ T512] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   53.665076][  T512] EIP: 0xa7ee1092
[ 53.665079][ T512] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   53.665082][  T512] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   53.665084][  T512] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   53.665085][  T512] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   53.733299][  T514] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/514
[ 53.734642][ T514] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   53.735708][  T514] CPU: 0 UID: 0 PID: 514 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   53.735715][  T514] Call Trace:
[ 53.735722][ T514] dump_stack_lvl (lib/dump_stack.c:123) 
[ 53.735733][ T514] dump_stack (lib/dump_stack.c:130) 
[ 53.735741][ T514] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 53.735754][ T514] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 53.735762][ T514] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.735792][ T514] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.735798][ T514] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 53.735805][ T514] ? elf_read (fs/binfmt_elf.c:470) 
[ 53.735826][ T514] load_elf_binary (fs/binfmt_elf.c:996) 
[ 53.735832][ T514] ? __lock_release+0xb1/0x167 
[ 53.735837][ T514] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.735848][ T514] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.735853][ T514] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 53.735876][ T514] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.735895][ T514] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 53.735905][ T514] do_execveat_common (fs/exec.c:1855) 
[ 53.735918][ T514] __ia32_sys_execve (fs/exec.c:2000) 
[ 53.735929][ T514] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 53.735936][ T514] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 53.735947][ T514] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   53.735952][  T514] EIP: 0xa7ee1092
[ 53.735958][ T514] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   53.735962][  T514] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   53.735966][  T514] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   53.735970][  T514] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   53.798688][  T519] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/519
[ 53.800190][ T519] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   53.801123][  T519] CPU: 0 UID: 0 PID: 519 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   53.801130][  T519] Call Trace:
[ 53.801138][ T519] dump_stack_lvl (lib/dump_stack.c:123) 
[ 53.801147][ T519] dump_stack (lib/dump_stack.c:130) 
[ 53.801154][ T519] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 53.801167][ T519] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 53.801173][ T519] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.801203][ T519] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 53.801208][ T519] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 53.801215][ T519] ? elf_read (fs/binfmt_elf.c:470) 
[ 53.801234][ T519] load_elf_binary (fs/binfmt_elf.c:996) 
[ 53.801240][ T519] ? __lock_release+0xb1/0x167 
[ 53.801246][ T519] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.801257][ T519] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.801262][ T519] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 53.801284][ T519] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 53.801302][ T519] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 53.801313][ T519] do_execveat_common (fs/exec.c:1855) 
[ 53.801325][ T519] __ia32_sys_execve (fs/exec.c:2000) 
[ 53.801337][ T519] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 53.801344][ T519] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 53.801354][ T519] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   53.801358][  T519] EIP: 0xa7ee1092
[ 53.801363][ T519] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   53.801366][  T519] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   53.801370][  T519] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   53.801373][  T519] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   54.845355][  T549] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/549
[ 54.846123][ T549] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   54.846566][  T549] CPU: 0 UID: 0 PID: 549 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   54.846571][  T549] Call Trace:
[ 54.846575][ T549] dump_stack_lvl (lib/dump_stack.c:123) 
[ 54.846582][ T549] dump_stack (lib/dump_stack.c:130) 
[ 54.846587][ T549] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 54.846595][ T549] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 54.846599][ T549] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.846617][ T549] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.846620][ T549] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 54.846624][ T549] ? elf_read (fs/binfmt_elf.c:470) 
[ 54.846637][ T549] load_elf_binary (fs/binfmt_elf.c:996) 
[ 54.846641][ T549] ? __lock_release+0xb1/0x167 
[ 54.846644][ T549] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.846651][ T549] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.846654][ T549] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 54.846667][ T549] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.846678][ T549] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 54.846685][ T549] do_execveat_common (fs/exec.c:1855) 
[ 54.846692][ T549] __ia32_sys_execve (fs/exec.c:2000) 
[ 54.846699][ T549] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 54.846703][ T549] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 54.846710][ T549] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   54.846713][  T549] EIP: 0xa7ee1092
[ 54.846715][ T549] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   54.846717][  T549] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   54.846719][  T549] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   54.846721][  T549] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   54.869008][  T550] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/550
[ 54.870370][ T550] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   54.871284][  T550] CPU: 0 UID: 0 PID: 550 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   54.871292][  T550] Call Trace:
[ 54.871300][ T550] dump_stack_lvl (lib/dump_stack.c:123) 
[ 54.871310][ T550] dump_stack (lib/dump_stack.c:130) 
[ 54.871319][ T550] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 54.871332][ T550] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 54.871339][ T550] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.871371][ T550] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.871376][ T550] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 54.871384][ T550] ? elf_read (fs/binfmt_elf.c:470) 
[ 54.871406][ T550] load_elf_binary (fs/binfmt_elf.c:996) 
[ 54.871412][ T550] ? __lock_release+0xb1/0x167 
[ 54.871417][ T550] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.871429][ T550] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.871434][ T550] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 54.871458][ T550] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.871478][ T550] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 54.871490][ T550] do_execveat_common (fs/exec.c:1855) 
[ 54.871503][ T550] __ia32_sys_execve (fs/exec.c:2000) 
[ 54.871515][ T550] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 54.871522][ T550] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 54.871533][ T550] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   54.871537][  T550] EIP: 0xa7ee1092
[ 54.871542][ T550] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   54.871546][  T550] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   54.871549][  T550] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   54.871553][  T550] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   54.918483][  T553] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/553
[ 54.921070][ T553] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   54.922747][  T553] CPU: 1 UID: 0 PID: 553 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   54.922754][  T553] Call Trace:
[ 54.922760][ T553] dump_stack_lvl (lib/dump_stack.c:123) 
[ 54.922770][ T553] dump_stack (lib/dump_stack.c:130) 
[ 54.922778][ T553] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 54.922791][ T553] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 54.922798][ T553] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.922828][ T553] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 54.922833][ T553] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 54.922840][ T553] ? elf_read (fs/binfmt_elf.c:470) 
[ 54.922861][ T553] load_elf_binary (fs/binfmt_elf.c:996) 
[ 54.922867][ T553] ? __lock_release+0xb1/0x167 
[ 54.922871][ T553] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.922883][ T553] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.922888][ T553] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 54.922912][ T553] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 54.922931][ T553] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 54.922942][ T553] do_execveat_common (fs/exec.c:1855) 
[ 54.922955][ T553] __ia32_sys_execve (fs/exec.c:2000) 
[ 54.922967][ T553] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 54.922973][ T553] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 54.922983][ T553] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   54.922987][  T553] EIP: 0xa7ee1092
[ 54.922991][ T553] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   54.922994][  T553] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   54.922998][  T553] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   54.923001][  T553] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   55.955551][  T571] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/571
[ 55.956393][ T571] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   55.957006][  T571] CPU: 1 UID: 0 PID: 571 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   55.957011][  T571] Call Trace:
[ 55.957016][ T571] dump_stack_lvl (lib/dump_stack.c:123) 
[ 55.957023][ T571] dump_stack (lib/dump_stack.c:130) 
[ 55.957029][ T571] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 55.957037][ T571] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 55.957041][ T571] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 55.957060][ T571] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 55.957062][ T571] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 55.957067][ T571] ? elf_read (fs/binfmt_elf.c:470) 
[ 55.957080][ T571] load_elf_binary (fs/binfmt_elf.c:996) 
[ 55.957083][ T571] ? __lock_release+0xb1/0x167 
[ 55.957086][ T571] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.957093][ T571] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.957096][ T571] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 55.957110][ T571] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.957121][ T571] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 55.957127][ T571] do_execveat_common (fs/exec.c:1855) 
[ 55.957135][ T571] __ia32_sys_execve (fs/exec.c:2000) 
[ 55.957142][ T571] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 55.957146][ T571] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 55.957152][ T571] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   55.957154][  T571] EIP: 0xa7ee1092
[ 55.957157][ T571] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   55.957159][  T571] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   55.957161][  T571] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   55.957163][  T571] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[   55.988164][  T572] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/572
[ 55.989345][ T572] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   55.990131][  T572] CPU: 1 UID: 0 PID: 572 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   55.990139][  T572] Call Trace:
[ 55.990145][ T572] dump_stack_lvl (lib/dump_stack.c:123) 
[ 55.990154][ T572] dump_stack (lib/dump_stack.c:130) 
[ 55.990162][ T572] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 55.990174][ T572] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 55.990180][ T572] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 55.990210][ T572] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 55.990214][ T572] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 55.990221][ T572] ? elf_read (fs/binfmt_elf.c:470) 
[ 55.990240][ T572] load_elf_binary (fs/binfmt_elf.c:996) 
[ 55.990246][ T572] ? __lock_release+0xb1/0x167 
[ 55.990251][ T572] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.990262][ T572] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.990267][ T572] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 55.990290][ T572] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 55.990309][ T572] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 55.990319][ T572] do_execveat_common (fs/exec.c:1855) 
[ 55.990331][ T572] __ia32_sys_execve (fs/exec.c:2000) 
[ 55.990342][ T572] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 55.990348][ T572] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 55.990359][ T572] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   55.990362][  T572] EIP: 0xa7ee1092
[ 55.990368][ T572] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   55.990371][  T572] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   55.990375][  T572] ESI: 00d25d0c EDI: 00d25be0 EBP: af97efc4 ESP: af97eea4
[   55.990378][  T572] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   56.024344][  T573] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/573
[ 56.025357][ T573] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   56.026627][  T573] CPU: 1 UID: 0 PID: 573 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   56.026634][  T573] Call Trace:
[ 56.026640][ T573] dump_stack_lvl (lib/dump_stack.c:123) 
[ 56.026650][ T573] dump_stack (lib/dump_stack.c:130) 
[ 56.026658][ T573] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 56.026671][ T573] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 56.026678][ T573] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 56.026707][ T573] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 56.026712][ T573] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 56.026719][ T573] ? elf_read (fs/binfmt_elf.c:470) 
[ 56.026740][ T573] load_elf_binary (fs/binfmt_elf.c:996) 
[ 56.026746][ T573] ? __lock_release+0xb1/0x167 
[ 56.026751][ T573] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 56.026762][ T573] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 56.026767][ T573] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 56.026789][ T573] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 56.026808][ T573] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 56.026819][ T573] do_execveat_common (fs/exec.c:1855) 
[ 56.026831][ T573] __ia32_sys_execve (fs/exec.c:2000) 
[ 56.026843][ T573] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 56.026850][ T573] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 56.026861][ T573] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   56.026864][  T573] EIP: 0xa7ee1092
[ 56.026870][ T573] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   56.026873][  T573] EAX: ffffffda EBX: 00d25bd4 ECX: 00d25c38 EDX: 00d25c4c
[   56.026877][  T573] ESI: 00d25bd4 EDI: 00d25c38 EBP: 00d25bd4 ESP: af97ec04
[   56.026879][  T573] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   57.050046][  T623] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/623
[ 57.050746][ T623] caller is debug_smp_processor_id (lib/smp_processor_id.c:61) 
[   57.051180][  T623] CPU: 1 UID: 0 PID: 623 Comm: meminfo Not tainted 6.16.0-rc3-00069-g631f4b8aed51 #1 PREEMPT(undef)  0cbed6a65f6df7396f9947ee56afba44136969a2
[   57.051185][  T623] Call Trace:
[ 57.051190][ T623] dump_stack_lvl (lib/dump_stack.c:123) 
[ 57.051197][ T623] dump_stack (lib/dump_stack.c:130) 
[ 57.051202][ T623] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 57.051210][ T623] debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 57.051214][ T623] do_perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 57.051232][ T623] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 57.051235][ T623] begin_new_exec (include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 57.051240][ T623] ? elf_read (fs/binfmt_elf.c:470) 
[ 57.051253][ T623] load_elf_binary (fs/binfmt_elf.c:996) 
[ 57.051256][ T623] ? __lock_release+0xb1/0x167 
[ 57.051259][ T623] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 57.051266][ T623] ? exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 57.051269][ T623] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 57.051283][ T623] exec_binprm (fs/exec.c:1665 fs/exec.c:1697) 
[ 57.051294][ T623] bprm_execve (fs/exec.c:1750 fs/exec.c:1725) 
[ 57.051301][ T623] do_execveat_common (fs/exec.c:1855) 
[ 57.051308][ T623] __ia32_sys_execve (fs/exec.c:2000) 
[ 57.051315][ T623] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-003-20250720/./arch/x86/include/generated/asm/syscalls_32.h:12) 
[ 57.051319][ T623] do_int80_syscall_32 (arch/x86/entry/syscall_32.c:83 arch/x86/entry/syscall_32.c:259) 
[ 57.051325][ T623] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   57.051328][  T623] EIP: 0xa7ee1092
[ 57.051331][ T623] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah
	...
[   57.051333][  T623] EAX: ffffffda EBX: 00d25d0c ECX: 00d25be0 EDX: 00d25bec
[   57.051335][  T623] ESI: 00d25d0c EDI: 00d25be0 EBP: af97ed64 ESP: af97ec44
[   57.051337][  T623] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250723/202507230700.658dd95d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

