Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E451F4611
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Dec 2025 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336196; cv=none; b=V3HkrwUE2oxqWHayJv37XTxTPXkWwinAXaB5QYR4xwh8kW843UKM5PSqjMBICBahjtqKgs6UTtAaSOtGetGS9HTYvyO5LOcGfRXfCdKt+nrrR3Gs9X3zrw5lBpbDJnDPN4jtOc+PSZiXuVw17mS6qvr11PuXtOkipOvakdNe+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336196; c=relaxed/simple;
	bh=EScQuIQpHOYMZ7vZy4ZDAM8ab5QBdJ1AS4CBWMup2wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUQCa0Y5kuSDCtIOCOijqQF0JO57IWZnVxiHji4pFzWGEz6jbggr8F0UP0yX/qAVsvLi4dalQj4kgKUBeficHDJQhnn3zs8mRPhZ9wWajWXKLZPddzGFXrJAGDndfr4ybf2gT0FtHM4pePxO7Hqw9Klw3q9RCHsiL6biIuvTFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3743F896BA;
	Wed, 10 Dec 2025 03:09:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 7564320011;
	Wed, 10 Dec 2025 03:09:49 +0000 (UTC)
Date: Tue, 9 Dec 2025 22:09:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Message-ID: <20251209220944.6ff1a578@fedora>
In-Reply-To: <20251208181413.4722-3-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
	<20251208181413.4722-3-tballasi@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7564320011
X-Stat-Signature: bbbjgo8eggigo9kb441sdos94ybpm13y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Mw/tq0GrYj1b/7THa4iMpPMQW6mvMW/k=
X-HE-Tag: 1765336189-187340
X-HE-Meta: U2FsdGVkX1+3QV7/E+Czttoxvu68qqIVrv1Zgw+slAu7J2VSyochonNUMCPalBvZB1c88lbwSKf0TXkG7G0dK73wrvjCf+YpxJLc46MtnStZXip5aq1rduD/MHo+mFF3QYa9n0929iAP2sM0DlTTd3rvlDRqbyUlPx/QEN0+qMpfAU/JOMA9Rwa41uQpl/zVCBt9rwFjH8/OW9W+Jr2mRqz7I5cBeJwbxigw6oyJEYYanRTBKntIu6SxQJVhAxuiIozRq0PWUTmfl2WakYr4+Nnkmey2mYzvX46/nlBZCfvpPxl3G1CXVDtkLDhe7oDSty6WQlDLMOQ5E4rlkKoGf0J8dwHD2NMn

On Mon,  8 Dec 2025 10:14:13 -0800
Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> ---
>  include/trace/events/vmscan.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index afc9f80d03f34..eddb4e75e2e23 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -121,18 +121,21 @@ DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
>  	TP_STRUCT__entry(
>  		__field(	int,	order		)
>  		__field(	unsigned long,	gfp_flags	)
> +		__field(	int,	pid		)

This puts a hole in the ring buffer on 64 bit machines. Please keep pid
next to order as they are both 'int' and not have an "unsigned long"
between the two.

>  		__field(	unsigned short,	memcg_id	)
>  	),

-- Steve
