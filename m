Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45261E5211;
	Mon, 14 Apr 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672519; cv=fail; b=DFtOA7QtvO+5vNsClUtwaExWfsoClA6TXjPnyz5d22jkXVTtezuxZKJFddJ5L869dWkDiqa+wOyFBcjXaqfI3q6CcK5lp9Sft8nKMgwfyXkDDhR2h05p23SpvF6swqrDzCO8SfraMn3fo8RXfraLL2BVDW+vEhHIoJRNPq8tPz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672519; c=relaxed/simple;
	bh=9YkCAj92XGuLgbKfZ/gD+mXFLOeHnWoBlWIL5QDW2Ag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CciGnLzif5F+tuNzDgJrw/V5TNWMcipt0YdHMVt3Uzfj38CRGznQWDdRoUJayQg1sN5tSt5MTBiNhv61p7jLwSMAP9lkjYj6H0ihG4sjPHjeICnjd63+MlfYoo9Lf1Jyezpx5Y21ClFe3cRGmJszkRodgwat++4y/o+mEOCnbQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=Tp5YCuSJ; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="Tp5YCuSJ"
Received: from pps.filterd (m0316037.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJ6rmB010014;
	Mon, 14 Apr 2025 18:14:29 -0500
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 460ahn2n1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 18:14:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykgFrCZWVM+jVR+k6KzUU/CNx1vD5g3p+Z6RESIG6TY5WQbMK6Vt4221Ek27BbP5ePWkYh72QeaN6rpTkexcJ1bEnPln+cAtMztGeWtBRIwsR+yMM6JKsjDzZQFUfP5alzbOd0LoWGzmDKnfCoyNi01+ygHzyA/8YSHA+9kQRd5/vY1fIx1GU3XD/tPfgZYLFtjBF4x0Q5b/6VH/JiJ+5mBbO/OPXgrE0koGaTJtGh4eq8vEnZfue0Jal5wIWlhLxBQgfa2cGQQqWdTnXTvy76k+VtU84IDKlsTxwQ3Vzyu/gv0wl6vutGA6vQX7zWp2bBCsUydEzMj9jZJ6XSMowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S5ElRixnzDD4kyIRw0ytkyQ1jnAo5SIra0jm3vfCkg=;
 b=o1KuLAeXv2K14v3CBGGeKrhUlzKnP1Jh1KVkKnOuUO6omczmOzGcA5N5hKbclKbc5KWjN+o6aHGAPzz8nDzdhG1YieAjrb6tAsRtngtA3LnD1zMmeEgVh3CgfLEoVlz0QtKA45BKQ1/0aZj8WcVtfu0Q2R2ulsROrg8VDw/Uh+Km3L4ST86KVFWgsxBDg3QJqR0QV39pf9iwPafWXrWqlKnIe02puNHGiGQzOg9axGg5AlfUfOUuXeFF+Icn5nNEK3edmGLn7ip5gOPZ3No45MrXDulzZ0X6Vm+17exIJf3BEPCzMmnB/KdjsWGHiCj4Yxy+hrOEMSOpj5UQrXXtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S5ElRixnzDD4kyIRw0ytkyQ1jnAo5SIra0jm3vfCkg=;
 b=Tp5YCuSJi23rp7aIuKhVb0NQYQ8NKQah8Uw3G9hOR0aeBzZobEv6hcM/slXy3Ssc7hRhvQHILtNsw/70vlD+a+D+xPNMV+dRKFeESPBx2d59HVrG2r52sALfFftfkOAOFftvS8o+X1dGs5n8/yoU6jZgOGAejiDsJSoJU52kbrvrlRBoIjjcQLvLwaa8u+gB2jGLrAhk2WCOe9ulhryfiJqFEb+nKquwKu+3S8ERwzpm6mMCXsjbBP5vouQOKb28Lrfr/zq6SwAUN4u0p9oteOF07Y/uzQJJcIT+/LIg1f5UrgMDFo7j15/HcXXzFR8BJrEVxhon6RdExXUlQ/211g==
Received: from SA0PR06MB6810.namprd06.prod.outlook.com (2603:10b6:806:bc::15)
 by MW4PR06MB9037.namprd06.prod.outlook.com (2603:10b6:303:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 23:14:27 +0000
Received: from SA0PR06MB6810.namprd06.prod.outlook.com
 ([fe80::c7d3:298c:69b0:970b]) by SA0PR06MB6810.namprd06.prod.outlook.com
 ([fe80::c7d3:298c:69b0:970b%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 23:14:27 +0000
Message-ID: <a40a1add-00a5-49bd-887a-5fc722c9814a@cs.wisc.edu>
Date: Mon, 14 Apr 2025 18:14:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
To: Dave Hansen <dave.hansen@intel.com>, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To SA0PR06MB6810.namprd06.prod.outlook.com
 (2603:10b6:806:bc::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR06MB6810:EE_|MW4PR06MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d06a0f-2c3c-488c-2861-08dd7baa19f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|41320700013|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm00SnFmUExRaUJQWHVZY2tuM0FiZnA5Rkc4MDh4RWdWNitXN2dKUHlaN0Z1?=
 =?utf-8?B?TXZrMHd3Y3hRNElRMWhSSXVySiszV2MyOGp0UlErU2lFWWo4bXlEVVJsVVBE?=
 =?utf-8?B?OVhnRWgrdnVRVUVuZzBXTTBxNERtYlVMcENJTzV3MjdPRW9iUkhvc0g1R1J3?=
 =?utf-8?B?dGRJTUk4VVFJS1BaanNEN1VYQ0pYUmxVT1ZDUm5hSGRRWjk4WkEzcSt2YlVY?=
 =?utf-8?B?MkVGdHVZaWJCbmZBZGU5ODgwSkswUk11SlcvbVdsYU51QWdwK0o4SUhHUXRr?=
 =?utf-8?B?R200UVFIM05GSDc3UFdOS1lYZVpEOGdUOE5XWHdkZzNhQnBhQkNhYzFhQ01V?=
 =?utf-8?B?bGJGVDhsLzdMZU01SlROVWJEeHBSZS9OS1RNWTQ2akR2ZXZJMkNQSGk5L2xX?=
 =?utf-8?B?elZPQUN3bWliSCswYWExbXhXSWpuSnJMbll2N0JFd2dGQU51enRVdlRkN0N6?=
 =?utf-8?B?c0taeHpVNXJZVE5tVDRSRkpVUlRGTXJXV3N1MnRlV29uT3NObXBjTktQQkJZ?=
 =?utf-8?B?UVkvN1FQVURNUzkwUmdWdmJNRmpkVWE0R2JRbjNkZnRHRWFvT2s1dUxxbXlV?=
 =?utf-8?B?THUrSWJlc1daZE5TS2ZkQ2t0ckFYQ2tiMThydXZzWmJmemQ3a1hBdDZ2M0Fp?=
 =?utf-8?B?N044YVI4YVpEY3dhVEtTWkZMMmU0UThpV0ZGb0R0d0VNL3J1ZGNSWDZYVU85?=
 =?utf-8?B?cmlhM0J3Vit4ckdFR1BaTEY2ZjNITGVMcXlIVlcyb0xCR0VTcG9GNm5kNWVy?=
 =?utf-8?B?TjJZWW9EdmpzYVVkOXROYytxeWF1QU9WWGgxK0NOVytIQ2xXRDJvNCtMZnVT?=
 =?utf-8?B?R0pVeEpoQm0zYnNXNkFnOGRmRFo4STd4V0N0RldhbHNSeCtUbkNWeHYxOGl3?=
 =?utf-8?B?eE12YklWSnpMYzNxNUpweVlEeU45K09WNTVGK09hTjdlY3phajZZUm40L056?=
 =?utf-8?B?NThNTmtuNDlNYjBJTnpVL2ZmRGdRYTVOZSt5QUVFZGJmbHJHUXFUY291Y3c0?=
 =?utf-8?B?S2tyVXR5ZEJ3TEtnNHFyQnZEMkxjK3lwUHpKcHZjbk5GY2w0QXhzejhBVUN3?=
 =?utf-8?B?ZzhreVBiNFM3NzAvMzlEZDhUUmdBaDZCSU9XSUtPb1hoR1p3WjVtWEEyOTEx?=
 =?utf-8?B?eFFoYTRhL2xxQmtvcGhmTWd0U0NZL20wT04zOXBoN01QYnVaMUdZU0taOUZC?=
 =?utf-8?B?VnRSZ1VVQXBxQ1pid2kzbEhlU2JRSW5vZ2dUODdKamkxYU9MWEVjTFN4aHdT?=
 =?utf-8?B?ZlB2L0xEV0dWME9HMm82NnRNMVV0dkhVNFZybzFGZDBKQkZPSGJ1OFBnaXdZ?=
 =?utf-8?B?T0Y3THhsamRPU0xEMzdBTWpYNzZqYzExZUUzdlRMSjhkM1dMSmc2TmdyYUh4?=
 =?utf-8?B?VUhwNVhBM1I5TjRCMXJOZVJ2WlVwbEVsamxwQkJpaS85dzBzZ0xnVXVSbDB6?=
 =?utf-8?B?UHNnZU5XMEdpQUV5OVYwMFJ1NzZtS0M4VWhzbVlJaDJmWmpGT0ZHTjNTQkd5?=
 =?utf-8?B?WEtweHdIMngyZUR5c2o3K2FmaHlNTTNJREo1T0RxejkreXBnQXliV2lpTnJp?=
 =?utf-8?B?M0l3K1ZBSWZxN0NtbTI0RUlleDZCdDM3b3FGaXpuVmlOQXA2cmliSHlWZW16?=
 =?utf-8?B?VzQ3Y3h1NHljcWQwR3RWeWZpNW51VEgvbFZCbDViNzF3Ukt3WGJtUlJ5NDNM?=
 =?utf-8?B?MnFjWHVpeVlCbXkyRjF0N0s4VzRGdDYyMGJBVVhrYUFKZHl6cUFjam9tbk4v?=
 =?utf-8?B?R1RlWk1OTllLY3M1RkRucVdZcktEY1kvVUNCeDZIZjVSbmRzcDhtZnVhbFl4?=
 =?utf-8?B?bnhkWWNySkFLOERCQUR4WGw3MHphQWx1dXB4WGRzbER1cHhvTFdxcUoyL0VJ?=
 =?utf-8?B?MDEvZzluTEVoMWg3ZXlaT1lrTGVXTFRmdVNZZGR4TTByakNCWlhBVGpmd3NY?=
 =?utf-8?Q?nuaKkY8iuPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR06MB6810.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(41320700013)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm9TZEFOYVJSNTI2Z2NRVHA5cEc0Vy92TTVINTBZNHZmdmFIQlpjcXdUMkFF?=
 =?utf-8?B?QU5KdlJTZ2tJa1plTG1LSitqTTZOL1Y4T21OVVo0Uk5YM3NMazdaUGxXQmFM?=
 =?utf-8?B?NTFCalFQTmtBNDVVL2F5ZFdlRVRIQzJHbWxVSzB6NEI0UDdaYkRjQlRDRWov?=
 =?utf-8?B?NVU1ZEljQzU4dVg1a0o5K0g1L3lJMDY5MG5vTmRwWU94UmZWZnlUZGhueTRI?=
 =?utf-8?B?WVBuZVVpUkNxN1pieWw2OGgveVNZUGhFbU02ZnpsOHN0eFlBQmRkYzQ2bkow?=
 =?utf-8?B?cWJaNVNzSnJXQnA0Qk9pK3B6aVRFYk52RFhCdE9ubnVCQ3JYNVFKZ2pJMGFu?=
 =?utf-8?B?L2wycVJGMkdkdkMxUzc4UXVkWEhjMlU1UXlRTkp2RlAySS9YQTlGaUtpQk5H?=
 =?utf-8?B?U2Jid3lURVRuVmxMUFdUVFgvYytzSVFBMlJBMEFzejlzY3hNenVnVGU3RTZy?=
 =?utf-8?B?QUR1SUsvbkJYMzBJRStmLzN6OEFucmo3aytCUjBGekhHZmxCNFkyRTZ2clBU?=
 =?utf-8?B?MjVWTEcxK3FwSVk4anZpNDJaZXdjVlJKTlhlOE9QaWZ2RXl5VHhqVTd5RHBL?=
 =?utf-8?B?TG5haE1EWTRHNFpIRGt3L3hzeWFnVE5jbTkybG5BRm5DelN0ZnRzOTYvOWEy?=
 =?utf-8?B?bEpOd1RmUXQwc3lCb3d2N0hqVTU4R0VmY0cxL24rcTV5WFc2M0FRSTBINHFy?=
 =?utf-8?B?UmdGRGt1VWNuaDdGN0FHVXlmSElDckY3V0c1UEMvTlExWkMrekRZUXh3bG1a?=
 =?utf-8?B?TlE4SkcvNVpGRFVlTmQ3eisyOXNHbEZMZGhhR1RlV01TaXB1SzlvRi8xbm5L?=
 =?utf-8?B?SGRtOUFSaWZvek0yOTVTVk5NNi9hdlNOK1FYbkZnOHJWMk1ReERHU1g4aFZx?=
 =?utf-8?B?d2FEWldyV255TXhMOEhSd3RIQWNMLzgzVXNLbjRnNnYyRXZ1R1dvakpzZU1B?=
 =?utf-8?B?dGJFeTF0eEhTUlBEMHFFK2hNN3hHZlNhYVNrUFVXUjFNckMvcmtjZUY0ekw1?=
 =?utf-8?B?eDJrYXZuM2VjZnJUVFFTN1VqUHpiaFAvczYyVklib21rZlJZUE51Wk9JYmZ2?=
 =?utf-8?B?NFFJYWI5M1F4WTZzdHBTY1RTdS9QM2QyellSQy9aalVrK2F4VktKOXVyQ05M?=
 =?utf-8?B?SVlBVENodkRNcC9pakVUVnJWeVRLR2Jnb3QvVnMxS0JDbCtoMzhZclgrUVRS?=
 =?utf-8?B?VmdiU05zUm4yN3NCbHJrdWtuc1JvaGZreWpCODQyeEZGd0F4WnprdWlXUGVo?=
 =?utf-8?B?YzZBMmtzZElQVkJHaGJFMDdLTDV5MjdPSjdrejJyNGoyc1VkMi83L1BsU1kz?=
 =?utf-8?B?ZUxubVpMcW5TNVZzYkRvK3NiSVM0dXdxWDVORHIwUkhiemoxZTJxL2NuTU9L?=
 =?utf-8?B?bGJld2NJeTlHRmxzbUc3eStURHdQWXE2NWZYRUNZcXNnRjNwQUpxVjMzc3Zi?=
 =?utf-8?B?WVRaalVXQmJGdGhVVk1GcW1sNWhPaUdLYjhOM1Q4SENxY1BKMktmMXNsMFRj?=
 =?utf-8?B?TExjMkg1Rkk5dW44V2crZmcva2YxbnpVQisyQWtrZVgycXJVK0tSOEJlM3Fo?=
 =?utf-8?B?cm1rVytmSWoyN2F2Z2hPb0dEaGxNRzZlUnpPY3BJOW9YUk95a2grMGdGN0NE?=
 =?utf-8?B?THVpYkJWQmoxTXNXK2l0RzVaZE1kaGVIMGJ6WTY5OEhTMEJOelI1TTlncEcr?=
 =?utf-8?B?ejJYZ2ZrRTB1NmNGT1haY3FXQkluRTM5OXlHZlQxS0hLaFprMXZ4SEtWVmxW?=
 =?utf-8?B?NTRYTnhlWmE5TG5PZ1VlR09IZGJ0aUg1UUNmbVBwMFB0R292M29qTDQvWEND?=
 =?utf-8?B?ZnBtazNQMXVDdUtBVHBYcjlZQmNJVmExeHRtUUl3WmNQc0hnQUFiZlFyaVBB?=
 =?utf-8?B?dEFsSllKaUdPV3N1dzR4eDhZQlhDSCtUUjFEZTl4SHMvUU5kSnJLNEdqUkxD?=
 =?utf-8?B?UlcxTllBVEQ0THF2VkRJOFJsMEN3MWlod01KcHY2WVluY2t3VUJ4Zks2cXRp?=
 =?utf-8?B?cHRaRlk1L0ZvUUpJbGI5TDVxbWZwUVlHRXNHeXE1cE1nS2FDN0RDdTgxUldo?=
 =?utf-8?B?M1gyZkxVaUJLTWY4QXcwSjhBL2lKa1BhQ1g5NUtLc0ZXT2NidHVwd2N5RG1B?=
 =?utf-8?Q?+4xs=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d06a0f-2c3c-488c-2861-08dd7baa19f6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR06MB6810.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 23:14:26.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUi8ECPLOsdOBEW8eIJSPc9llciskp4KNRPOYDQzQuCXM0OVHjS9IXYGwHyN/7rFi2DUwC4IV87MrC+e1raM0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB9037
X-Proofpoint-GUID: 3nhumT4RzX3lpJvCVhM1yA3upzR97DiN
X-Authority-Analysis: v=2.4 cv=eOkTjGp1 c=1 sm=1 tr=0 ts=67fd96d5 cx=c_pps a=OYTBATO8h6EMnG+Ds1NGug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=bfroKfSIdW18apzhE8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3nhumT4RzX3lpJvCVhM1yA3upzR97DiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=617 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140168

Sorry I forgot to reply to the list. :( It's my first time doing this.

On 4/14/25 4:56 PM, Dave Hansen wrote:
> On 4/14/25 13:52, Junxuan Liao wrote:
>> On 4/14/25 3:42 PM, Dave Hansen wrote:
>>> Is there a reason kprobes don't work for this?
>>
>> In this code path it's either noinstr or inline functions, so I believe
>> explicit tracepoints are necessary?
> 
> It'd be great to turn this "??" into some more certainty. ;)
> 
>> As Steven has mentioned, there are similar tracepoints for irq and it's
>> nice to have them for page faults too.
> 
> So, that code is:
> 
>>                 trace_irq_handler_entry(irq, action);
>>                 res = action->handler(irq, action->dev_id);
>>                 trace_irq_handler_exit(irq, action, res);
> 
> ... I think.
> 
> That's a heck of a lot simpler than a couple static keys and new
> conditionals.
> 
> Also, I honestly don't think we need separate user and kernel fault
> trace points. Maybe we should just zap that in the process.
> 
> Is there a reason we couldn't get this down to something dirt simple like:
> 
>  DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>  {
>         instrumentation_begin();
> +	trace_page_fault_entry(...);
>         handle_page_fault(regs, error_code, address);
> +	trace_page_fault_exit(...);
>         instrumentation_end();
> 
> ??

If we don't need to separate user and kernel tracepoints, we won't need
those static keys anyway, and it's indeed much simpler.

Do people find separate user/kernel tracepoints useful? For me, I can
check regs in eBPF tracing code instead.

Junxuan
