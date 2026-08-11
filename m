Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1030CD82
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457472; cv=none; b=e4sLy2KYBN75ozlhrsz9I4QOavtms0AEUXAGIoYyiA9IVMZ1bc2IA4G9Q3mTxj0j+H5CS9ABxrvlxsN53T8HHnZ8k+TAjhmMjRLYisgpSI02r2FvnDMVVUkqG0NlB0l9atp2ehCyD9A1l/+gmI6u2y9um7IBG0sM/tUXQNFmNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457472; c=relaxed/simple;
	bh=fA7TFLlTEHQIhNI824n5aejQUgHRt7cDKxD4tfzqGB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWYihoRCGoodX24g9+VXXqKwC+fCcU9PQ5v02OA2YCjosfxFA4GPn/+t9jJaISKTJiQQM7KJexCUiVY3EBculm4blnziA8Lg/affXGNEcVcWCkTaWp2IWzkhTrGtE/yGKYi6FWCjvdr1lVbj7FcMrRS3SGfODYC+VhF0BtBpwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nItx9pSX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nItx9pSX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so201077466b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786457469; x=1787062269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6mMde9A+9sjPPQb0bVj2vas2ry6tbY6Ai2B4U4G/GM=;
        b=nItx9pSXK38SryppqkFMjjQCDZ61/P3mIaXryuT6bnUijmVRlyitIodgTqTCBdrPpH
         BIzxVBs/w73Ce9cWx/1n3Syesiokdt8MafcJy1nH5ZuDfqRp4EvKfrPqgUWnpF3Jv4fe
         dtfhT5jGHTdImkMND4LYlzGOH99cKcODw6EipxRJxp3f/QGn7/0f4O+R2KGECr4/i1PN
         7Aozfc6By94+tQeRDr27QbWrp/4ABjcr0NdNbyAbtDujuti/WKtUUNf8/McxZ8grzK1w
         4FCar5/EReU/EFOvjCBHOYo/FUgNEN4Syz2SXtU6SVlq+iA9nZszo7Be2arhJNaRG8Wt
         yVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457469; x=1787062269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6mMde9A+9sjPPQb0bVj2vas2ry6tbY6Ai2B4U4G/GM=;
        b=nDQjUHM6tfF9wRI/EJ1TcsTv36wjL14mxXDnoHzrLyuchXkrm8GkFlMyrwyTFw1IQa
         uPvGzlijbwYyvg0pgYVTW3/fZte6Ars3oTgchuDyPNZzWjQVLnGWUnSqtHFWJAVPe7w8
         FL0IWzZYSXuoUNTJiQkw3CN4ApeEnWuA1nowV1EARbZ01abvjn5MNPCXHVDsEB4Gre6t
         kzPxkwUUd+6t0ALQeCj0+NsFRvuehwDcd11q+2To7rPGqepkrVsWJ/s8Z1+j9YYmdy0T
         JLAXB3ZS0Oo3OQBbhU4lteXaXSKTrF/Jp44PPMumslCKOE79fdIYoX/qryG+VzDH3Lxu
         m89Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq5lyg6J4zOoKZ+ezK7XYB0ZLYyGiahZ2QGn76xvry82cqG4mxcfTFtkxMJ5nt4/EpTe8Wh/WhBmtmPQJAtKfp+394=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8MZHoLc8UOHVJvmj9R0JyyV0R+DwcnZAmG9CGSbLqxZuOhAX
	pNibNGCbou/hzp+iMI9iFHDONOfyYyZVEz5+JguUhQowiwQwZExJFTvZQ0hxJkmnbw==
X-Gm-Gg: AR+sD12ve/v5K5a11v77NKx1XnhGJkJjj6ZpVeLniLVhwXDZxDw4aKM8e7sBZhMnrwo
	RJC838ZzZbKiOjELkocQ2dkSWcx9tjW0VZR4sn3HqXA1hP1iRgoZsbLXI3xBzEwtqcWcil3WJok
	P7ymVKBhtSMmrZ0sVOmqZD5RnksMZx1tD9UNSuRpRg0W1xaV0v1+FB2p6rIsLMHoKsip6k75DiK
	4WP0GbOyIESm9ZQFdpReXq+XQFYEJ83pDG+ovJp03sisAVActLNXdso4XlzXZ+jV8IkPhV8PzeK
	P8T9taoCc628cVWf3EsdBdSo2k3Fgs4JrVHhY+W8XaCA0QRq1xXfindZzl9DsQyijlBMghBznG8
	BtcgyHPCbS0NImbaGDsoJYBC3BBglXWLJsabrv/O6YG/c0LH04DC2jHvaTv6PBAedhIQxSYlbiC
	AWItAreDotizRyTENKDQJh4sNENepd/A/4kVHXwBzOyieCIZhWl3zHSFogqYS18Xh2R35W6nG5h
	AJBMCRX/tIiCAW1f602ctfw1Tlv82QF
X-Received: by 2002:a17:907:c245:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c20ed0206bemr30442266b.2.1786457468608;
        Tue, 11 Aug 2026 07:11:08 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e431f42esm63763666b.34.2026.08.11.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:11:06 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:11:02 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <anstdpyNVXzYzTl3@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
 <20260804140333.797210-7-vdonnefort@google.com>
 <20260810184216.3484cfd6@robin>
 <anrmx86wMG0Jh-E1@google.com>
 <20260811094857.69dd650b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811094857.69dd650b@gandalf.local.home>

On Tue, Aug 11, 2026 at 09:48:57AM -0400, Steven Rostedt wrote:
> On Tue, 11 Aug 2026 10:09:27 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > This is a pre-existing issue, but if an oversized event causes
> > > > trace_remote_iter_print_event() to return -EOVERFLOW, will this break
> > > > the loop without calling trace_remote_iter_move()?
> > > > 
> > > > Since the event is left unconsumed in the buffer, could this lead to an
> > > > uninterruptible infinite loop (hard lockup) when reading the trace pipe?  
> > > 
> > > I'll let you answer the above.
> > > 
> > > -- Steve  
> > 
> > I don't believe this can realistically happen, trace_seq buffer is 8K and remote
> > events are really small. 
> 
> They are small until they are not ;-)
> 
> Is there anything that forces their size to be small?
> 
> -- Steve

I don't see anything preventing the declaration of a massive print function at
the moment...

... and neither the registration of an event with a size bigger than a page.

Is it something we should consider? I have ignored it (in both trace_remote and
simple_ring_buffer) as it seems very much unlikely anyone would do that.

-- 
Vincent
