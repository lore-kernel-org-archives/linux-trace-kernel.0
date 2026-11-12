Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508401;
	b=viS6u7Q3GTwZRdL1lUlOSO0R7pbkj3VtYPgxmmgHqemXVQwm4bjT226rCkHVF6axQ3st
	 9PP+pcVnFD85znXscSS7pY5gz4xeTeRpxr3iDyct+FCV2hzfYSZbz6l9CMr4NefnZbpEX
	 kPjaBCCGV4acPmJiqdOzJwI7/zg+3YH1M0kDqhp0xKROU0t0AFUF8yj3+P6b29wnsbVQ5
	 zOHGL+dN5R6X0YYU7GUi0cIdsGGOoKdqgv/8tSH+bJqBGE75J5MITuJplifpfpwNLmfwQ
	 GiM/zGVjGzlDXN5Y2roRtF5WJenccu7dw77lY/mQG/w1xOnJdsXn/9NCEll0y+dMITQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
	b=3u5E0cKQIl7Dr6kmSHG/ej2a/gUZPJkArIq9iOEnMrATszsJFoN81fo/43ZNq1GdlySp
	 SoEtKWTYvEKNNKZ7O0pi6v2lDuGV37vQIGuBKajnguTIJtM6QF2QaoHP6RWcbjvFgoI9h
	 7C8WtXaUI4ou3sxJv5yOO5XboRmyUO3wiCHzl6lH0/M1yPYdRYugGoD1NJ5XmCG1vHDzl
	 DSkGN6smg45iPTxdgPGA0GMKYcyvj48lps/DOlhl9X4dxIx/4omwvLCUAQEMQ2QNM4fNu
	 LqyOYSTGlYQE8wprTnErfsNq+FEZGBoWwsEPwkt9PnCB4fN8mgRfr9vepBGTGqJ72zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpJb013w;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AD606A895
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8AD606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpJb013w
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so1881032a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508399; x=1795113199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
        b=bpJb013wg86TqxRRlt4sD67lUpI5p2+GLIho39k7oCu3QGTMGi+VmybFlQbzbYOvWa
         TnZ2bwWfbluvwDTDSUeNSX+b7jc4Lt6Zo7P1EPak/SThQLr7vtt0X9DHs8IqAKxVDdjN
         g5KbnjYEuuYMYhMMw1wUa41FWtu/T5h8r29aCpnwpsIvqF9xt0gVlLDJUM2x9pwUjy3R
         2XnCBtztXNRasQLxA1HL+pN/n77Tk+Gj7idiZOnJCKOk4HOTKBadsMG1mqQrCDYruHN6
         IANIFSepZ5jOz2SDRsvUfch8m7CLPqfCmxRZ75qu00DNEDZpWs7nqlhFeNLlpGutHtrc
         crxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508399; x=1795113199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0890/1KdBxvDOFaG5+6Gtq1sFZ3f+/3xUbaBwJyo30=;
        b=RkqayWOawdCKN0aP4vT5fghR55/8ECmoxvY3pooriryDa1AdkZ1A1/UMKaZtv3Qg/K
         0ouwlP+ZJG7qgehiESbcYl4QTrLWrXSkrKSo691N4qYihl//oJsUy6HAuB0Zh0V12uoU
         ubajP0d6a5CK+uN7QQc17Ce2z1qNj6NKMvVxN5SUTQlBWizKxl4YjvEipitvMbUzyzJK
         JTyLSZiQ1FJZ0EgK1RgkjQbNOldoaNTTgd8YB20732R8V00iw8xKh3D3+3M1Fyl8bb0b
         sv/qkG+1uB9Fexsf+/3KLapUAaM0/fUOATzZsSpASwygG4iQkoGrLkDytFVco7b+3Qo9
         Y/9A==
X-Forwarded-Encrypted: i=1; AL+hErFtH2pgpTZ5qUberqUGY6oDmgBcIi09MlMwICYZkGbAcxGPPpRh1lva9ecCLsJ6h24qFgcOdNCnMNBG8zVjV7oLAqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LU3D50bGLM1zVX4pLf/32uFBU+lQlqmZ7fkkOfPIlPNUwsXas
	3yBg9pCp+ICRt852T6Pt6kYRzLSb1+/tuZecCgfqbbQ26FHd5NTqWWRr
X-Gm-Gg: AYBFou03P/VWOyqUDPYBULmZ8s/wR1ESnOxaBAkSvXQ8BicxcgSQUgheswxHNx1gFKD
	jsqNauGR26BBP0m0fT3CI/oHG5S9dA/0/lreqvG/57VN0ELTM5cOLqhuq23RTHGOJ8wvOxAtkXv
	Bcxr//Wc3RcXwWyxxyW0YaV+1uzWVYC2JnTeoHNSKAQHEgYRuZnm56m1GaAruPaEmlANIryVY7L
	j42M6TijNgtbMUJHlzfcHQVIY+nuPatTLH86ok50IxB4SxSbDrEoa5ar5LPbFsQmokurSJsLa8K
	iIHtNo0lMmzj/Ol6hvl78AkW6e73hsgFPkhp42V2bGZf6F9nOHsg2OWi56n0pbensLe6yPHdqBW
	yXp5Z5IreKsjIJQZRm5mk1qO5Ydv8mRH1S9W01qMb8vfHJUFDYmvUV8y2ZbJXeesXVX0bkXU1p3
	vVwIBp6KoD7qAKkykfTnLtscsO+leZSnA+JLVeZptFvEyxIZYcYYZRKo+nz6i9ayEHg/35H6jSa
	kJ7GGo3aJiEpl3Qs1aOJI4XhIcg4OShzo1GwPKhZcO74N076FWIaNN799CQ55kboBeVWzsZGDw7
	oXx/+2WSAXhNDV8X
X-Received: by 2002:a17:907:608f:b0:c4c:a409:5aa3 with SMTP id a640c23a62f3a-c50963879c9mr11899066b.17.1794508399520;
        Thu, 12 Nov 2026 10:33:19 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b68dbbsm5890066b.61.2026.11.12.10.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:19 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:16 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <avYGbCrfomowKKiH@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112083413.GE2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112083413.GE2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:34:13AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> 
> > +static int static_call_site_index_cmp(const void *a, const void *b, const void *priv)
> > +{
> > +	const struct static_call_site *base = priv;
> > +	unsigned int ia = *(u32 *)a;
> > +	unsigned int ib = *(u32 *)b;
> > +	unsigned long ca = (unsigned long)static_call_addr(base + ia);
> > +	unsigned long cb = (unsigned long)static_call_addr(base + ib);
> > +
> > +	return cmp_int(ca, cb);
> > +}
> > +
> > +static struct static_call_site_index *
> > +static_call_site_index_alloc(struct static_call_site *start,
> > +			     struct static_call_site *stop)
> > +{
> > +	struct static_call_site_index *index;
> > +	unsigned int nr = stop - start;
> > +	unsigned int i;
> > +
> > +	if (!nr)
> > +		return NULL;
> > +
> > +	index = kvmalloc_flex(*index, entries, nr, GFP_KERNEL);
> > +	if (!index)
> > +		return NULL;
> > +
> > +	index->nr = nr;
> > +	index->base = start;
> > +	for (i = 0; i < nr; i++)
> > +		index->entries[i] = i;
> > +
> > +	sort_r(index->entries, nr, sizeof(index->entries[0]),
> > +	       static_call_site_index_cmp, NULL, start);
> > +
> > +	return index;
> > +}
> > +
> > +static int
> > +static_call_site_index_text_reserved(struct static_call_site_index *index,
> > +				     void *start, void *end, bool init)
> > +{
> > +	unsigned int low = 0, high = index->nr, i;
> > +
> > +	/* Find the first site after @start. */
> > +	while (low < high) {
> > +		unsigned int mid = low + (high - low) / 2;
> > +		void *addr = static_call_addr(index->base + index->entries[mid]);
> > +
> > +		if (addr <= start)
> > +			low = mid + 1;
> > +		else
> > +			high = mid;
> > +	}
> > +
> > +	/* The preceding site may overlap @start. */
> > +	if (low)
> > +		low--;
> > +
> > +	for (i = low; i < index->nr; i++) {
> > +		struct static_call_site *site = index->base + index->entries[i];
> > +		void *addr = static_call_addr(site);
> > +
> > +		/* Later sites cannot overlap once this address is past @end. */
> > +		if (addr > end)
> > +			break;
> > +		if ((init || !static_call_is_init(site)) &&
> > +		    addr_conflict(site, start, end))
> > +			return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> FWIW, we do have bsearch() as well.

yes, but bsearch() returns exact match, but we need to find first entry
after start even when no entry matches it... I'm not sure how to do that
with bsearch

jirka
