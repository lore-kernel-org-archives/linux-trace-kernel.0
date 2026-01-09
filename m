Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3A35CBB7;
	Fri,  9 Jan 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967205; cv=fail; b=W1z4EvrTbIe2OvFhw5CsmEN7DU1Mlwi7FV2m8KOHnevd47qwSo5fCMrH/gdZB38t180Cg8/vSEUb2YUIQx9jp0Z+T7A306aRdx6B3qxRbAy4ba3OfPwwl4R27MwPrZZpSongWMgj45/D0v1Grj7HA0MC38mOYpO0rXsZEpURGZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967205; c=relaxed/simple;
	bh=cbsHmchlMHVflohpl5C2ognh7OgyvYpNu7T5cty9uIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+nv87/z1eY33p1DYi36DiVw5Xx+I1sUYA2fXYSpVvG0GxihppTFPTw0ueZo7ioIe/THibFVDvmPG8JtVvjDkDsqdjoUhgf3ure8QGSowMJS+J2GYd+9LOmCT3imz8v0tWx5TvAgUBVxvPcjgLLbRjcOfKWiijpp8jWgJOlSwzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owbVmU9j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gcSLrdIZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owbVmU9j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gcSLrdIZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609D1ddK3034838;
	Fri, 9 Jan 2026 13:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cbsHmchlMHVflohpl5
	C2ognh7OgyvYpNu7T5cty9uIg=; b=owbVmU9jnoW4ZMynRM210v1lPnad5mNoEe
	vq9u711F14pRHQSazzfWJc/QBfs/MpnTTef65rO6ZiFfNMzlOpJeicZK5qSzT1Xu
	rIaGcnUj/jnJxgTJ3/J4kub18ZcUpZL9OYy5chWxT+K45hbIC2gDN2OoSbp2qb8Y
	tP3291MLCl0yr6jRTY4g/sx6sKb+7ISmqoRskH5vRV/sVPX73Fom6JwrWpLkfL3s
	JvcLkw4D6Kit17vUhMTS2HXDM/F4/g5IQ5hRwUAnd69EIRGs+mdsfBxd/arG1Mj7
	5BI37Va2Se25X+C9phLizCzI2b4akKVxx2ZM1wckzPDK+smAvzrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk26p82ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 13:59:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609C50mp020359;
	Fri, 9 Jan 2026 13:59:09 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpdsq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 13:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koskbH+VGaPvCLB6DE0R4Zf+r8zVBWzzubJpsXk00sqZylsiI5JkPgdbxpr4WShw8faXR4HOPdLBOc90Le7j7Oz9a/bRIj3YaEq73XBcFJ/P0XfN9ruEfxXOKTlKBK82PWzmF37T32vQWRwXiMTPCqEmy0RHl0HMWSUE3Yxj1McqNQNmPmPAdVzS+xwsGXQy3WBR9qwgU/qF/BQyJ+Ym0i2/MZjuHmIUcZbxTsR6t86sipmual2/M39z+YskCU6OlphMSZNbuqTJ0b0iIQ5lyBzVT3Z1OD1rxge2BSWhwRu/6HgRXeRxGvJs0U/TeTI66qJx4f9XtgUO4G31exw2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbsHmchlMHVflohpl5C2ognh7OgyvYpNu7T5cty9uIg=;
 b=KzA7TzCJGoj/HDuT4Ep4Er//kJOtMYp1cP/JxOm42XrCE0x0j090YK/D631Nr5OjrJTgd+t9FIiG1mcXa85tTBrdV5PijKboxv0g6Co5TdroJAMN+JmkDAEEWUYblIEujD/pJZWqa/B84q6Los91mD1al7XH1ZUITyIT/xcInOkBDfY8PYOpNsVR99CKtxEc8jm2AaeGwlENKLe7SmfS6ay19IdPPNW+GF8HCs2ZkY+sq7V9p+jCUGO17QRF4ILsAmLDcgDBmn/x+5O+nqEO+fEX7OsXcoOm5oJ7+sEG6YbndbMnBH+Ftefnwl0ikbByuhG7eXB2u6r8X52qyZcnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbsHmchlMHVflohpl5C2ognh7OgyvYpNu7T5cty9uIg=;
 b=gcSLrdIZ0/CagN9dmnRBuXlDb7AupZbtUXhNbxxkx2NZYx9/cMy9QnIHgxkiOElJVeJWBz5arKPn/5val9oBAPYLCTKhgqq9im0jAeYzvr/SwVTth7N/Qgg1VMreRBq1q4r5jak6Uv2Gv4Lki9laLM2kqF2ZfwHokFkZFmSEF+0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 13:59:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 13:59:04 +0000
Date: Fri, 9 Jan 2026 13:59:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
        rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v13 mm-new 00/16] khugepaged: mTHP support
Message-ID: <33e5b77f-ab18-468d-a254-3d44955285b2@lucifer.local>
References: <20251201174627.23295-1-npache@redhat.com>
 <e54b6ade-e2a0-4a68-93c4-23af85479567@lucifer.local>
 <4cfb49a2-f0fc-4796-83a6-91db3a0f2a97@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cfb49a2-f0fc-4796-83a6-91db3a0f2a97@kernel.org>
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3877e756-96e5-4af8-763f-08de4f873fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ahfYaNIRbB4wxY1t/rdJWU8N+hbKG8IPXSWKh4j5G1eDu7qMLEALI0j4W1A?=
 =?us-ascii?Q?gLwWl7D5+R1fVjoQFjrVXTxPW0D8GgplYabTSXGhvsSFnxZf8+W+uuKZx6+I?=
 =?us-ascii?Q?xHUp+fPEJnQQm/6nddfhcFLgIOHEDgUScnXeyOLtabTMbAagFRFK7JVahtdh?=
 =?us-ascii?Q?VAFrxXmRPh7QkoLLUMgHnsK2F0vDN80RMqLxSA4Fk56Lb0HYRWsSCZofFg/D?=
 =?us-ascii?Q?6XaZk96uO0lpqI9Gm2UYbBOPRZYHoJYv3oGCw4CsHYVr7quknUU7/aGuXdab?=
 =?us-ascii?Q?QWx/60SPrQcIsCSapsWvmdmJi0hhND7VZgsKnAupeS0nQl6xAMJ8/IEQKCMP?=
 =?us-ascii?Q?fIm6IqUWbaP4zN0IpwkX156mACQjEFSO5DnNhNAuuS9ORP1RqiVhBhHcqgrq?=
 =?us-ascii?Q?PE9K4DgsEp7CzRU2A2IMAOSeCu29nJAYu5rjGE6mTwZurrRAq5WwbxGk/Cu5?=
 =?us-ascii?Q?64axlKQBHW3SbN4caLuS0Y2tvd+j+Uh8jXVwbzt3O96LM28Czy1OWa75o9ay?=
 =?us-ascii?Q?HERvGLAyInT1cp9RRaLqmDyLx0iqbzJq3KWIgldTxM/VNoPY7TZF5r6+IyPI?=
 =?us-ascii?Q?76nB+E1vwFlH8VM3KCfQBRlE7104zRVIU4VtSJ1te61d0f8DUkE5SAGQYJdX?=
 =?us-ascii?Q?mNU7iO2N07RbrPRZhcfbKLtHwyJ0r2FxmtI+upcaD0EDz+kHjDWbcSfIE8wz?=
 =?us-ascii?Q?68j+455+Op9SdoVVR4L44KEWb1FDtFHl1r6Udr6nKHXUWFTg/i9jG4GIA7M5?=
 =?us-ascii?Q?S1jUXlBccLqEKpsUiToDgtzg774SZhMvQXD4tYNBAdScQxA6YczMnRBxYnQa?=
 =?us-ascii?Q?V/3ImAf9c5OChmh0Zz7V7IxgHgYVliJuk+lcz21xqUjB1inX9izYbEVpiCbk?=
 =?us-ascii?Q?QOGkuussyPJN2JvxNlDrTklQmghrb5CIovk7t2reZrOI8i03oieoLpjFR094?=
 =?us-ascii?Q?mH82PypzElFWW+ZlHtlpJ7KS+MBTwwLGPyUZKwHrxaLwrQONFKdY2ta09Ba4?=
 =?us-ascii?Q?62grdC88ivBlyjrard0+nVAonuNPsmosl1V039qVfvR4JJ+hp1H77E78pyoK?=
 =?us-ascii?Q?w3geO/s4Rfo0SOZFQdUpF7rui9G/l45P3XZ9/EaN4VRF60V9F/xjUnecZSso?=
 =?us-ascii?Q?63tHWxh8KpG7yr2rIVd/BCYCwEZ8CMbiKtZR2v+pDfh6W1kXie6eeqrHKk2H?=
 =?us-ascii?Q?SrDFXoMRB0oKVQ9kcGg/BFyqMeAnMwE8cBSzJiw8kZXE7yLT3P4zznn5bMZ/?=
 =?us-ascii?Q?MkgVw3cGJSOiQ37O/Wj5rMUCi0t2P0xdez/2GcakfpXFfJN9jQOAf/lAMsss?=
 =?us-ascii?Q?2xm5YhdE6FhaZKO9xV09Bu2pWfXIVmaV8ilVpKN9NQACCaFSNlz1dWT6h+v+?=
 =?us-ascii?Q?a/py31tbP4cpYCpobdB4Zp0EnAXL/HbJP5Qwo0/KqSMl2a9s4AaIXMXJRtCE?=
 =?us-ascii?Q?BWbnWlnzNvKEpHsozrqhMrGKjEt2xyOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U88dV+lDfxidrFl6phNqDzkxxW7FN3XG0/Isf3zaXipCXLPOQSYz9J8splGd?=
 =?us-ascii?Q?dZhLWV+sTopStAbkF/IUCwFn/7VP636FqSfPJKOz8PUNflcdVatOqvXKF8YP?=
 =?us-ascii?Q?4Q41nexzHttG74z+8OsKwS3YLTJY5vpql9MZ1yM4g7Rf/Z3FJsU3A1AEDbN0?=
 =?us-ascii?Q?gxOT2s1uX+YCIZub9SAs02nLz0exrJiuzNPWQJmlATKGLyUIS/8/RSE4jGIe?=
 =?us-ascii?Q?tZWJtRxwtNMkKe1/Um+tSMYjs4rW7gP56jg1RfZ9iYBgaSSHmJ1IYYoT6eKj?=
 =?us-ascii?Q?rmEAG2fXSE6ifTwr1Cg5HgMQbzU37l9ARhcEY1jS9o66haiOElClou/J+HDf?=
 =?us-ascii?Q?1MX4PmTiGuHrpwP2Qgz3aTXg+lOQJIQwbRBCS+HE3CuPj6ruDtm0iPTTJNYw?=
 =?us-ascii?Q?O9oi44piTyClzSrfh4ejTxI13MqOsRS43TT7AKKW+FtzFjjXaue7poeg9A+p?=
 =?us-ascii?Q?/3kGKl5n6mZ1M664WuJvTdN/nuQYg6WergGRADw3Ipoz9nROF+Z9daHEYg8I?=
 =?us-ascii?Q?3Yvbm6SN1SuUUfc5D9E/z+cHBMFurQj7TdVOovDB4pT/hdPICACR1l+9q/dK?=
 =?us-ascii?Q?5FgwF+T6XL5maTFfrcdj35K82jLvL+AZZHQT3atkRzSEoag5KgfvV6kiOYrq?=
 =?us-ascii?Q?LCSlG9a2t6mJ1ULfNFrjAB5CNB8abZ83I9lQ9mx9ugAmAgRXVd+hA46ZTl8o?=
 =?us-ascii?Q?OR3MWu2ImdR2zJY+9+WF2NK8UkbpamQbHbk5fj/swhHmYC/sgZQredMZ1JCW?=
 =?us-ascii?Q?CgWnQJe9gGJilqeycvU28Ii0RezwsStTQXGlpPsS8rglwLNb2vK6HSdgjV6k?=
 =?us-ascii?Q?z4aYVGbzVzu2eZEMIN37HvpxpVsf1XkZ2Rk/b8ZAEDF0ldj8uHco629NCh5d?=
 =?us-ascii?Q?0mgDWIp38DCrmyBiOmJpT+MHr7ETcNbrIizO/QAaiOVn44PKv+IKIrAEiP1i?=
 =?us-ascii?Q?c9YkLplKIU7ed+vxOx7S7hxHKyZxhVoC+omSxgggKXb0PGRASIqpw2F9qzk6?=
 =?us-ascii?Q?99NoO0iBDergE5lg+6KX4MySnRhSWXU58pM/NWcAsmhZiqY384Yb7vQpZ0su?=
 =?us-ascii?Q?5JXg79Hq1q00BZsg0QYoJ3RZoswhFNxBT06d1qYrtTUtzYWTs0pdgHvgAOuK?=
 =?us-ascii?Q?7UBOQW66ZzCVBpS2dmOnuim4q2suFcMGqf47IKvmaiOOkFnSYs6kaL14vQ13?=
 =?us-ascii?Q?ZTquWV0dlDJNjKp63SsPvwTyxBH92/GDyIEY9tD5l3Q/WdgnV0GC7tqFdLUN?=
 =?us-ascii?Q?n5n2J+FzpN/xCf0/1M8l82zpN30GFjs8desMaH3u0Z/omsXNClHxrkPpFm9v?=
 =?us-ascii?Q?EDT+XhHQdv65EHolyt4zmdXDn/IM5gyeo2ZS2sgNN/Rkr44Jca4ncIuFmYjF?=
 =?us-ascii?Q?T9NXH9XKnzYLgUJ1aEt8gAgo92j9fLcQcoaDsuwg0veixZK1431nVgTLP4T8?=
 =?us-ascii?Q?8/tG2u7Fyd6UDz2Op4D5eKMtrPFSLsbTayyAgcGCkn5SKtXYpBZDjmTW2txY?=
 =?us-ascii?Q?RorYN17x4qpzh3NNQXi1iGZK+WfIP9BMt8vlGRbAnZ+quBtCHzNNVGdmXPd4?=
 =?us-ascii?Q?rEwCM/QhC9rfdr4Q2oEzD6+heqf9E+zZ4Jk3fb+e4fByGBvjOSiHL9Ah68uo?=
 =?us-ascii?Q?yI8qrzZ5A8r7wovli9wemApVYgg9bjMfm2K42hZ+YEUNB791aW/cNpCvoFVb?=
 =?us-ascii?Q?1R0lXokiPHfDyh8RVb0BNUtpnbvaqp+3HWoDNDPqG0kHWfa71eORzXvLEOKr?=
 =?us-ascii?Q?nlT2yDRl840kJ7+EwtrkIQDLrPSLCpg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AoWYeIscDHm/sFhz6XSJplGk8VIeY16NKG7FTVDvSPydt9PXf87ZGDNrAPoNJ9F2+klKlWO2RyQRSbbGZGVg2hFR0BXSPhStVUopLdYCZSyI17m/PSivqgyhh257ymiw6KQXs4u8m9e8PmF8WK3AFt/3MX9LHK3dtTf0ifpT6CTcgJeSGc7Bo6TNHs9VndzOhpFPSqhM1RRVD4FSIwMpmDSksqeoHRdwPwjbfEA1jOVDJ5tSuVZP07hyPhoKdpwodkL+2nec1joYths9eibKhawjVihS1gfkGfvtJYXktrppWrmgKnyQoAGkzvM4r0+J1mM3SfirD2aTebs/WhTO5hOp0InATb0pH/LTpeddktTx3vZeJOIzNDOSIi7vfoQOCuvXzoYO3VvUPn+IL3mEiCLaFX4liY/wQEGSq6woAwtZoOcFKft/zwT1X9TULQKKKH9G09XEIa8O92+S0bD+FlivMbXPKbF28haOteBjM+IFP1rvbstcIbnp+EH7sliJ4mTPCTGpfOro7IVWUDLVbbEGH1I0qoBa0Q2muwl6gv6Vwj6uUdAaNdQrJ+V7mBys7dF9O4eUnTgrzzyqydeL23ih7J9u0hL4k9DiuK48yMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3877e756-96e5-4af8-763f-08de4f873fa8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:59:04.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Ud+pwYf6UkWDj4ArBPvLvKpj/FwB8Uiz/MsAB93HpfEqh7vxrkqbP66w98iPIJKxYAB91TaLPwn2KhHaqH34jbLvCiX+mW6DC/ZILp0v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=832 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601090104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwMyBTYWx0ZWRfX6MXNd9TVS4Gi
 iEEiY9D9COp5VTvOu9YnnuLFnfJCkb+QmH9AU//+T/LEsaaBQTQ8RCc1HKGwZhpPR0F102lPxHF
 B3ArbY3TZcpmb1BgcLr1F2QpS0iC/m5zYTNDTzKF6DetltAiahEpElHcpP/tfhtWF+M5b+6ikdF
 yWtKBFQGF3RsaG7TRa7W2k1j3iFhmA8D6VBWS3oGNOjGylMdzRDtuLIqPQBoVjTVDRsF6NIR2zk
 eRInqAC6ap5ae81fFXFQ9D3pemw7XKaYwskSQL2osBXHiH2/RDmwzZrwfyN3ym0tD6krcsRS6VG
 +Ra9ig6Of97ZGlSm0NDP2vtjFS1/wVG31tiRVPctQG4BqHu5OWZjz653SDQI6hINuveDegujYFo
 P0Lpf8w0ezOYtBI0ULanu62BF1gZXtCbrAS2Z5IG3q/YcAVg+E9+OKzKvJ+N5boBMO0Lmnxn36k
 G/jOn7LOEbxXCW1OsSJqdWF15iz3gdDYzgQb/o+Y=
X-Proofpoint-ORIG-GUID: 03LY1SMp-6wh2Jwf3o23kP_tebvBfl0M
X-Proofpoint-GUID: 03LY1SMp-6wh2Jwf3o23kP_tebvBfl0M
X-Authority-Analysis: v=2.4 cv=HuR72kTS c=1 sm=1 tr=0 ts=696109ae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zKKimXo6f5T93VLhIaMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109

On Fri, Jan 09, 2026 at 02:57:16PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/8/26 18:19, Lorenzo Stoakes wrote:
> > (Sorry for multiple mails replying to same, lei/lore are broken again so my
> > setup isn't working properly).
> >
> > I tried to fixup the conflicts here to run tests locally but there's too many
> > and I messed it up.
> >
> > Could you please resend this series rebased on mm-unstable please?
>
>
> And maybe send out the two cleanups that can be applied earlier separately?

Yeah sounds sensible.

>
> --
> Cheers
>
> David

Cheers, Lorenzo
