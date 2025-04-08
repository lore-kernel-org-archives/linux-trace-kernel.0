Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54742550A1;
	Tue,  8 Apr 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142977; cv=fail; b=TDMEMKMz63AdWAM8y9e1yATUF5dleKHvaPzZE9TWOArKD91oAesXNjMls8fTg64ySi+NzzVeupEaMs5QA/YPdxVOrp2gI3zHGL544yXUYuxy+ldA8HyOgTwjK8uA/xDENhlfnJ0PcVkfyMAW7LkQaWuJ0FuP2BcQAtAdAMVPrew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142977; c=relaxed/simple;
	bh=QN/2YxMtzhzClNMKVR+hF0XP9IAGoh730xGCgGSz7u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GmUcn0yNLw5mC1RSagyTXS4tTyBC5xQRLeXrzjnL4iXcpmCiO5pf3M8iDTB6ZPmRBm33PmTuZrDKUDAaxFb0FMoruoERDEqaTihe8mD/9ISkGd5eetcwLvsroPpVrYlWkAgmDratruUFzo4Iv8VcvsL2H4AZ6i7ZTAC+Ce5UTmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VzO0Uubl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=km8tRE8Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VzO0Uubl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="km8tRE8Q"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538IC6LZ024020;
	Tue, 8 Apr 2025 20:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rcJCSQcvMmdZojLf7N
	y4Vqmyw7bb8OvMgLjgp+zPFsg=; b=VzO0Uublc6bqOzVowZCMweXTNqBiCNZSAK
	s8NwuAysOyRehwcgc0OXL+Wd5QS59t/6ZVCzH5wBIgotM4MhN8KYkqrv0z6rhrjE
	7HMuru3x7285ZV/cd4RS3XDI6hUf/6Y8NcJJlVmKhjOr3Uh1yhfVkx9XNm+Ok738
	RtnbmVBQE1o8LlXL3MkIrWCUhbwhFr3CWJbkDKXzNOZGV2L32RXrVeTLUM2X0PdC
	J2jiwCV2Iw/G4Tha9MNIWLL6SxbjJ0jcLUEIoPV5rQPFIUds4OjE/LgZv0agRW5W
	RJJSlRq2bKpnEj211Nbzg2sc8IVd25IPn7rggoo7nALSaj3FXk0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebnrqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 20:09:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538IUYIN023786;
	Tue, 8 Apr 2025 20:08:58 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyg4ap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 20:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlhIVJLz5tz0uKq/0xxENC1nu8ey2KU4hh12515Ws6pGQdfGO75noISk6K3fFLlMu5oPYn7T1vcQPO5TYiKVbgGfbAtJXFcSvZ/gqI0eRenVAxHEcEODXAaJLnwTiy6sMucpTbkh19i9Z+DO9bEm9hYIjkIb1KxTktuYlYnem3s/4RmxkKDqRpCo/NrdGPcAfO7NPt52kRKUjE+nf0tdI7gpfA+86wxOdSTvMcHJ7+tXcgkII8zLmcgOzfrz+dyjEVkdgKB8lPVoqEf073Hx3/DnZC/01233i8sp2ZZfpQgTyopY4Rzz7okHrnf+Q4Nsb/p59XC4pA3XGc+DnqBPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcJCSQcvMmdZojLf7Ny4Vqmyw7bb8OvMgLjgp+zPFsg=;
 b=cR8ixg0oseFcaaLL1VT24lKH7XUJTcLi1Nn673KDStmJvWnXp5xHOtQQWH9DKcErdQKsuyl9yn24wpv+FNHkC9wtEuRcGFj8c50qPfYe/MlawPS3am4ssO7MGM2N7ICjZobzHdycyXy2drdih6Hed4921c5YdT0k3sD8InXP6cm0IeghmMt5eE7cMbMURMbm4iBzSxIpiTPc8w1f3ablpnPy99IjGdzjYzQqnvcYMIUZoQ5dDjG+hWH8bH+vTSzM86KZpNY6yb/nLqchgRodkdHnRhls6z9k5GWINeYPGlmcJwWT3053twmpXbjo48Dss5gDet2NREqNBBx7zMMwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcJCSQcvMmdZojLf7Ny4Vqmyw7bb8OvMgLjgp+zPFsg=;
 b=km8tRE8QGKh8DKZYX+YeRciXKmXo3KiNt20X+f6No/Gyj+/85TMg06ZMJ+wYQCz2KGOvjk8y6BXmWS219OKnN5560zC3CvEIlS464XZMP5moyARND4MmYhMCbyPpp2E5t+CpC9kd5ygP01wZc5RwYlM2C8Ph/+W95DWQRn195DY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB5770.namprd10.prod.outlook.com (2603:10b6:510:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 20:08:55 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 20:08:55 +0000
Date: Tue, 8 Apr 2025 16:08:50 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Sweet Tea Dorminy <sweettea@google.com>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin Liu <liumartin@google.com>,
        David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Message-ID: <eskqatmgerfgm2o3tv3or7v64i2yyups2fzl3kancog5pjgtnr@sj6ljqvyyir3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthew Wilcox <willy@infradead.org>, 
	"Christoph Lameter (Ampere)" <cl@gentwo.org>, Sweet Tea Dorminy <sweettea@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
 <Z_VWc6Z90rhfyLBp@casper.infradead.org>
 <iqa7gvbcwyw76jd6cgimp5jbu4szxob5ptjvi3rzll6amfjygg@cunm5zrgm27e>
 <bcebaacb-ef9e-409d-b770-3057a96c3d11@efficios.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcebaacb-ef9e-409d-b770-3057a96c3d11@efficios.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQZPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c48b19c-29b1-4b75-9a3a-08dd76d930dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VG/Hs+RFgTq7U2CxxXU2dSj/vqkjua4C9+sFfPlTKBFEVnQjid7loGUgsQ7/?=
 =?us-ascii?Q?hintzomjTO/BnboGDTulsBd/zodVT5etHW317H3hPnh1NkdZoeJ4ueVS4TIs?=
 =?us-ascii?Q?brCUqgSYpLAhOtqXsw8kWCAC1V3VWaV/sxsNdXllRr/j9GS6Q4A/lrtkOvM6?=
 =?us-ascii?Q?7U0rYMADhIePR+RBeyP/nUxqsugGd+sjgtDN5qApQz/P5FKnjCHnl3L95NmS?=
 =?us-ascii?Q?pAxGCaxb5qNv4rG4GkAPWeEgjNlfXvLFlka3YkZcezHaD9eqErjypy0La+gO?=
 =?us-ascii?Q?9yhk2sfko5TqhKWjqch7pp8YGtSyAtyFneqpvKm49IYBabl+64pqP/6yXIp5?=
 =?us-ascii?Q?xIqoCEN5khCHoeuJWYz2L7BubHbJlMHFJ7ORzHnjav95iczbmm+XIy/vMcvc?=
 =?us-ascii?Q?xpiy9CQ8nrwSXbd6Faqsycc4Hh2+6y07bmeWD90c+ooK5vhxFyYU87YMQ+T+?=
 =?us-ascii?Q?1XJz9sDlHTsKoyYD9849p/8uhoJqzGZOzigpk3bCxsk8bnziPAN0TzvSV46A?=
 =?us-ascii?Q?hN5WQc7q+UErBaVSa4WF9tvui4fn/gWu8qtM3rfbKEfR8EP9YeUU8w3OHaB3?=
 =?us-ascii?Q?R3SYiMFF8NjuazLd8TQtOu2crhysd+5EWQy/R6fIk2m11ERO3uZ8SMxEhQnY?=
 =?us-ascii?Q?CrPH3YiFTMMqYkg9KQm10whX4gjMSEh24idQHqAW68urAc2BvUcjieoFpoNB?=
 =?us-ascii?Q?3HkOe521yt+E1sa7PClOfp/hieF3r5ixnMWZqGNY0Kg61IUfDIn+MNdkjX8o?=
 =?us-ascii?Q?JAsa+IAWOIMhFqaLibPGtJrp82IkTM94Ip5UkRvqD8mzU3kKzzPU/qOYMokz?=
 =?us-ascii?Q?jktoIDX/YcMDBH2oE0dzodiVA4I8OO4+CuhkQrn9BamU0sylaMMGRUTRjtlH?=
 =?us-ascii?Q?ghblsjCIbflTAziIsM293YgA0Nz4E9grwWtjtJW/y++JgCrKSztnuCAywbZD?=
 =?us-ascii?Q?4ecHrw6QuD7L0m2hucyvh+/oLN5TjWdwfepZMthVR9gYudohrf3+PRyrlbd5?=
 =?us-ascii?Q?HLBreodvw8FyBnK51jCW+sIH6g01NNli+d/h27zs7YcI8Dj8eJOnRWAus0m8?=
 =?us-ascii?Q?QwEI2dDb0LtpR8YAuP7Yu6JZCTcOPlOrz9xLtQI9UFGtFhwCAOmaYvnQed/j?=
 =?us-ascii?Q?5L6jYw5NNDKG9QP498cYQPianHdRio9ndb+7T1gkCgG1s1pbDaur9E+xWGRJ?=
 =?us-ascii?Q?EercYgNlgXifsivrbXbXrXTYWRWEANZ5kCI5XvmIXIH+nZKi0cgycqO09wyR?=
 =?us-ascii?Q?QkXo3vFDr3CcLFd46F0PBrfqihV8FkxzzFX3QxYSa5mJSUl0Sxe5oljn7LzV?=
 =?us-ascii?Q?E8qxiD+MuOmi2Pe9FHbLrmsUUA7PAzZkYL1cnZYYnl95+aUytKw7HJlxRe3O?=
 =?us-ascii?Q?MzAa/mdxmmmKNh4rbbY+9gk/FLDJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4oWTUSA27KoIB4dkfi0MDWXKyQ0WL/W8kNkqziWa+RrdhLZLmHNE0mm5WXP?=
 =?us-ascii?Q?5wqX8ZNbzKDOZ01cJhUVmC+4CQeiQVZ1xTkbHEwpFZRXO7ApvTjetKA4U17h?=
 =?us-ascii?Q?X89SJOoLalvPgcNlmqlLDNhHJzIeuIBg/iv89xKKv7HV5ixpmIZvwnMykcgd?=
 =?us-ascii?Q?OKE8YI17925IGyRaQZvb2wu5Y0bAMVciRsLXp6cZCc0GxFyLNWthOVM+GJAo?=
 =?us-ascii?Q?B2/xoEztpTG9AvNd142Fx3KDbyKcOxoVLJXLtSroY86QB9hSjoMAhdBiFVtv?=
 =?us-ascii?Q?0SdQWueaebep3kIzygGMXHoC0Qw+6SJxG6GAvurI5dqAICAIlrTENn2z2hPc?=
 =?us-ascii?Q?zORmhbPy2x70D+8s1S1Lw56M2l7Yg0mp3Iq6guZtU10f0pgiliYLSeOVaSgd?=
 =?us-ascii?Q?zQfeMI6VakAKm6ZQxuysI0+/E3O+pnvv3u1avCv/vjgcpOrW2iJXa2dWtYEP?=
 =?us-ascii?Q?70byrDWxZyLBuBWT/goNOj8W/pgLs2Yu1hPvUWKTVjnVpDxJnvJP3F06lPzV?=
 =?us-ascii?Q?ye22x73DnIgR6Go7JwJGjSiT/9RWJjKx/Mv2z2lwbObU/7S1yS5fkERrY3/O?=
 =?us-ascii?Q?y4OheJSd8vNtNA1YpkA/AOkawbkROPgwSAPgsfjMZlNnNRMMtKj6yQbmIMI/?=
 =?us-ascii?Q?UZil/SiXRXBsJq/aPWQX+VEGEDyJw5BkIJq5SN/cZw07cQrkLfrvkDlYEv0A?=
 =?us-ascii?Q?9yJiYB4OIwcUdu5m6hYEkuhDoZuKwO5hVHOyvPIcinv/r9pvTGz8uyZ//9tK?=
 =?us-ascii?Q?4Enj/52SfpxpVxmsc2bkelaFHSfURLa8k9o866m6UZs4483hWOf4eRJEJocr?=
 =?us-ascii?Q?AJellzbtcgZ8YR3ryx1bTPtXxNwzqx4jS03F1aVcQ8RXVI/ra5PO5Ws+QVZv?=
 =?us-ascii?Q?ieJcS3Ie1Oj0bboTVXYtAuSIkZYFb+xsS4JxiNI0iLNOG7qHU5EBOWazPS3i?=
 =?us-ascii?Q?vOCqcLe/8+2i6ID8RF1ADf52A4UkHOPDbttY7tsBoB415FVulA+4mNsN6UFe?=
 =?us-ascii?Q?C7NjB3O1Y29j51OLgiUJ25NqZoDmGbLpKukcwZckQmWW8Vt8HuJLnm1N2GJN?=
 =?us-ascii?Q?1zC1aacm8RfyZSpBYzn1F5aMwGvuLCHhRoFa6ZIaeMdg2CvyVfLDOtL3p0As?=
 =?us-ascii?Q?F/AazFLNYMvHNKiVxk3Q9SKQrYPe4BXXhsx6tMQyvDowttZ6VvLj+Ss+O6H0?=
 =?us-ascii?Q?zyn+vfmeUuXkJr1prDkuXNWJdL+RD0bNA8tpjJ9Ddahmz1cXsTndzNsSMhNn?=
 =?us-ascii?Q?+s83gx6+4m7sICCanCXS+Z3KeuyDR8OIN0mHJsZeBSzrldongKfFyGk+je8W?=
 =?us-ascii?Q?4+e9bRICFsUVXiYTrC9DFpNIzxiV4EKr/WDxShVfOqEQ7ZbbiVqQXUPQOZJJ?=
 =?us-ascii?Q?KrgvKhXOxgKmgosJXJ1i9iXWp6/8x52bfjPioFGpQ3u1+vNvNA3/PEZUXIDX?=
 =?us-ascii?Q?zZPcfCaItMNHSpdCBXlRqXxSorOC02+DQngYP4aj6f6wByDgoQ9HWtDxwgAx?=
 =?us-ascii?Q?u5ZBNJ+/e+YAjpsQWKSfEdIGZ2slQYZWFqMPeTf9HfG4LCO1+uVbmSAg+jT3?=
 =?us-ascii?Q?j2AJoF2TnvR6UBpT8t7wHWuU7ibYIqPFwXRMx62/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HM2HvY7BMVAVw93geW7gyRXUnS68fpFcl1dZjYpCKW3gLtcee+APFfwNzU06NP+fkkpAuybSFaktcgZlc87A1VMaVDMlPLbCz9xwP7LhfhVnJafs6p2aakfQLXG8Rk+PKWrIxeYDzvZyVJCls69Q4i7bOfhhh5tQ8PaVJOZccuHweS+7Keup4ttpyT+mf+9iwDm0ip5DyVgdswyQUxi5pax5X0vodL9bjOlBrcoR7fIWMDO19WfAAcynExs7QGrfvyELeny7ZoSQG+1pAf/vky8PUTtHsoNmkXnAvLX/rOaKP6BghbKYgMUig+3CD0nGvjYtiJF4wObh+n9QSNTXT6Uz3OVpWyJ2mZAWds35EvgKiez+IDX/4VY0S9kxxTvcgNzK9rZzP95OrG9HwYmIx2jGsv7t3AlOjAIOAPNCyKN86Fu6MzLtMuowjUq07Ar8VPj80OOtR1EyK1iyG5l3HtyonIx0do/tCD3SEAt2SMQZmSdX8CUhzecajd6ZxfGDjJr2fpP+B3rE+X9w6Lj9HbozpsSAMWAsXoFZJRNt36Flbfkf5LY5as1Z+2Lea67O56bmYq4eHb4unki0lIxHktXalsHx/9RIgXCh6HJNgdw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c48b19c-29b1-4b75-9a3a-08dd76d930dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 20:08:55.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygZXywolzqzHvKjtFB6/26nle03JIHDk7zpTqGky12+MCZgLoxgrIN2Oa2UjQiZF/rqX45Q54LD/HJ81HJZuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_08,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080140
X-Proofpoint-GUID: Upl4YioAAQYDE0XVScHfUWqUm4Ggh7yc
X-Proofpoint-ORIG-GUID: Upl4YioAAQYDE0XVScHfUWqUm4Ggh7yc

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> [250408 15:40]:
> On 2025-04-08 13:41, Liam R. Howlett wrote:
> > * Matthew Wilcox <willy@infradead.org> [250408 13:03]:
> > > On Tue, Apr 08, 2025 at 09:37:18AM -0700, Christoph Lameter (Ampere) wrote:
> > > > > The hierarchical per-CPU counters propagate a sum approximation through
> > > > > a binary tree. When reaching the batch size, the carry is propagated
> > > > > through a binary tree which consists of log2(nr_cpu_ids) levels. The
> > > > > batch size for each level is twice the batch size of the prior level.
> > > > 
> > > > A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
> > > > on a 512 cpu machine. Given the inflation of the number of cpus this
> > > > scheme better work up to 8K cpus.
> > > 
> > > I find that a fan-out somewhere between 8 and 16 works well in practice.
> > > log16(512) gives a 3 level tree as does a log8 tree.  log16(8192) is a 4
> > > level tree whereas log8(8192) is a 5 level tree.  Not a big difference
> > > either way.
> > > 
> > > Somebody was trying to persuade me that a new tree type that maintained
> > > additional information at each level of the tree to make some operations
> > > log(log(N)) would be a better idea than a B-tree that is log(N).  I
> > > countered that a wider tree made the argument unsound at any size tree
> > > up to 100k.  And we don't tend to have _that_ many objects in a
> > > data structure inside the kernel.
> > 
> > I still maintain vEB trees are super cool, but I am glad we didn't try
> > to implement an RCU safe version.
> > 
> > > 
> > > ceil(log14(100,000)) = 5
> > > ceil(log2(log2(100,000))) = 5
> > > 
> > > at a million, there's actually a gap, 6 vs 5.  But constant factors
> > > become a much larger factor than scalability arguments at that point.
> > 
> > In retrospect, it seems more of a math win than a practical win - and
> > only really the O(n) bounds.  Beyond what willy points out, writes
> > rippling up the tree should be a concern for most users since it will
> > impact the restart of readers and negatively affect the writer speed -
> > but probably not here (hot plug?).
> 
> This implementation of hierarchical per-cpu counters is lock-free
> for increment/decrement *and* for precise/approximate sums.
> 
> The increment/decrement use:
> 
> - this_cpu_add_return on the fast-path,
> - atomic_add_return_relaxed for intermediate levels carry propagation,
> - atomic_add for approximate sum updates.
> 
> The precise sum iterates on all possible cpus, loading their current
> value. The approximate sum simply loads the current value of the
> approximate sum.
> 
> So I'm unsure about your concern of writers restarting readers, because
> this tree does not rely on mutual exclusion between updaters and
> readers, nor does it rely on cmpxchg-based retry mechanisms in readers.

I don't think it matters, but I'm not sure how hot-plug affects the
tree.

> 
> I agree with you that updates going all the way up the tree may
> negatively affect the updater and approximate sum reader performance due
> to bouncing of the counter cache line across CPUs.
> 
> > 
> > Working in (multiples of) cacheline sized b-tree nodes makes the most
> > sense, in my experience.
> 
> I'm confused. Can you explain how this recommendation can practically
> apply to the hierarchical counters ?

It would apply if you switch to a b-tree with a larger branching factor.

Thanks,
Liam

