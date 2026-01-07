Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E68190473
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752264; cv=none; b=iCVJ4PjM7jiuCxeDeJ9vwjZb8YZHgCnkLN4ZSq9OT5NS5zJTvOjt9m6dr39bAlnE4C4Pn0vcFsExTZ8ygGp24Rf20P4CQSy3wpmpe2BvyrTKRQ5oGVSp06oMZto7zqyzyT3D7YLelGBysXq2Nm4p+JyojfeJYrqUG97R4k+S/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752264; c=relaxed/simple;
	bh=iQrU/hmOjEOvQYI5LD85WfwqJMg0nJSQ639lZOkOb4s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VwR8Yp54aPUqUBfCwE3ndjAZ1fGMX5GvI21TRWknG+CDp51DYx0Ea9v0aRHyDewwDW9VWQYd0mhySfoNGZTyPJAcnjEnqrxv3DEOYjGot+0cRkdAzip0QnTS2qr8YYrbyaexdl0KgFVdgW0PbJ3xB0YOyDg3txmlmizuMlJSHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hVQzAGd+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hVQzAGd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11308C116C6;
	Wed,  7 Jan 2026 02:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767752263;
	bh=iQrU/hmOjEOvQYI5LD85WfwqJMg0nJSQ639lZOkOb4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hVQzAGd+H2ptGMJHZz8I8iIbYdQ7PNqIM/RsVFPYwaknc0NvNCXK9M5Vxp3viN7Ks
	 6PsLuVVIXuO4tm18SH3HVPtEVbSn2vYQ5xGcJ/OcGUiSnKQhdOLkQW+132VARgRZWG
	 HhIyB5eFmhSwcFXnwBbDngqr7rTC366kZALWTBCQ=
Date: Tue, 6 Jan 2026 18:17:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Thomas Ballasi <tballasi@linux.microsoft.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 rostedt@goodmis.org
Subject: Re: build error on CONFIG_MEMCG=n
 "error: invalid use of undefined type 'struct mem_cgroup'"
Message-Id: <20260106181742.5d55894e50139fd7d64f6dcd@linux-foundation.org>
In-Reply-To: <aV29Xj2wo786xVn1@hyeyoo>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-2-tballasi@linux.microsoft.com>
	<aV29Xj2wo786xVn1@hyeyoo>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 10:56:46 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:

> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -208,31 +215,34 @@ TRACE_EVENT(mm_shrink_slab_start,
> >  	TP_fast_assign(
> >  		__entry->shr = shr;
> >  		__entry->shrink = shr->scan_objects;
> > -		__entry->nid = sc->nid;
> >  		__entry->nr_objects_to_shrink = nr_objects_to_shrink;
> >  		__entry->gfp_flags = (__force unsigned long)sc->gfp_mask;
> >  		__entry->cache_items = cache_items;
> >  		__entry->delta = delta;
> >  		__entry->total_scan = total_scan;
> >  		__entry->priority = priority;
> > +		__entry->nid = sc->nid;
> > +		__entry->memcg_id = sc->memcg ? cgroup_id(sc->memcg->css.cgroup) : 0;
> 
> Hi Thomas, this is breaking CONFIG_MEMCG=n builds.

yup, thanks, that series has been removed from mm.git.
