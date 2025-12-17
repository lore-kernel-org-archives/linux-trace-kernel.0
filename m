Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD118AE3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009998; cv=none; b=YLyZ5+QRxr2tRIOhhqA2Ufj8a1c0ppqOSI5Eq//wcdh1Ztr3/88KN5d4a2jvnuI8iogUbloDWUhIqkaJJYPROTp4dxFQQpAkESyBXDae6S1TgzaRGI6APhykAlpYtK8DZ+LtQRJ9LwHxV/ZaKZCL6vj5d9DEytZp88fCFHTAgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009998; c=relaxed/simple;
	bh=mbeGagChTCQYXRbDk/SxRslk+XWPZ0ynYPSlBN8f2/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKjQWY/Vsk/e0Ihv9ML2jDLDqsXrs2VrLJJrj0GJLAFtzkQlLmCcIF9BFsjnmNIsZ1FRV5YEOXDmtOM+CsWPZ5bckiWcjLzNfKLjv2DWexKkV3VSw08YJk9MWOIC+mNsTx/6sqz/s3iGf6RJBEt8DcpdO19zgxNHp1qog6uqFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 69709160A3D;
	Wed, 17 Dec 2025 22:19:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id ACAB82E;
	Wed, 17 Dec 2025 22:19:52 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:21:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-ID: <20251217172129.724c41a7@gandalf.local.home>
In-Reply-To: <20251216140252.11864-2-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
	<20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20251216140252.11864-2-tballasi@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f5b7zdn6p8foedi1anmbumzzdw8ppz13
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: ACAB82E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+i23Pi9VijgAv0wiuOMPrlDUDyfeGFM5M=
X-HE-Tag: 1766009992-305526
X-HE-Meta: U2FsdGVkX19aTPnMOX0Iq3Wqm7D4si7ujpb5G+dn07pB95DyASlVuNnm0Ynhp4ZTCIrz5M2ZgZmkTHqRiqUsup5SG738YSc2yD1VBskZTt7t0kEEg+OMy6+c174/d4+WluPA+gTLRYxPojsl3c2q6YH02CpX80kS3RMEbMg927mL74lMLBqsA5B65RjXNwDLQgDtsWCHAY3TAewslMxM179vso0b6mNQpIBT8ABZTKTWVxNzh8Sx0UGIR0+fqYgwHPz2Ne/eCbRibcuU2guTeZCmOMbu1feiVIWIW5Hg2q+IKrHEBhetGBoCQ21rGiDQ8a2SC0e3IsqOZ5fJUQ2hdlUhlZ5hQmjE

On Tue, 16 Dec 2025 06:02:51 -0800
Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> ---
>  include/trace/events/vmscan.h | 65 +++++++++++++++++++++--------------
>  mm/vmscan.c                   | 17 ++++-----
>  2 files changed, 48 insertions(+), 34 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index d2123dd960d59..afc9f80d03f34 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -114,85 +114,92 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
>  
>  DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  
> -	TP_PROTO(int order, gfp_t gfp_flags),
> +	TP_PROTO(int order, gfp_t gfp_flags, unsigned short memcg_id),
>  
> -	TP_ARGS(order, gfp_flags),
> +	TP_ARGS(order, gfp_flags, memcg_id),
>  
>  	TP_STRUCT__entry(
>  		__field(	int,	order		)
>  		__field(	unsigned long,	gfp_flags	)
> +		__field(	unsigned short,	memcg_id	)
>  	),

Hmm, the above adds some holes. Note, events are at a minimum, 4 bytes
aligend. On 64bit, they can be 8 byte aligned. Still, above is the same as:

	struct {
		int		order;
		unsigned long	gfp_flags;
		unsigned short	memcg_id;
	};

See the issue? Perhaps it may be better to add the memcg_id in between the
order and gfp_flags?

-- Steve
