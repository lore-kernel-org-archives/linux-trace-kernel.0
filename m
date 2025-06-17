Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30572D12F7;
	Tue, 17 Jun 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161493; cv=none; b=ZhTyuhk0FN3Qia0TwM1FK9uXAeUPeib9IYHSiW6vF/++TevMgLJ9qcIw2xixHLh7UpFjV0pYXdXcDSNpv/2cj+sgQ2wwyt7xgu9Lz/4+S8f0YZbHQ2aIAmTT/8KpuaK3xhKFbn40i8+GXALmjV7qiiedq+FVqPeYW10PVUMiUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161493; c=relaxed/simple;
	bh=9OLdh2NGryQfmDtM2Fz5KGiePLaw/bXfVfqGVqpThNo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbF/dugPi/W7qOULeyUyiUi2ORZz0rAhRn/lE67z/t7nuzPwZn9vpCVbZKhxJSD0ehSsxtPon3uIC70HhObb6ZzVInm7V6Tc5qoCW/9V3zwJPGKoSoli8lrumwFnXhlFSEJFRLLYg6JQSp9u3Mt0WgN0KwNKlQMaAfMw5gAmvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrqVcL8Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrqVcL8Y"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ade5b8aab41so1199254766b.0;
        Tue, 17 Jun 2025 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750161490; x=1750766290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAyN+ToNafItED7vOGd5xwZjLyU6vZgREgdnOsl2nNs=;
        b=TrqVcL8YaeM4ndcbzqbmdSYdOQHLh59HYTLNAV25+vpDnifLs13HlpYOU7VuWTF59P
         fm15nbyfeRwHxcB6UNDP5KKnnXSI35hhLHiTxSbp5lJZ4Y0VuKUT99t+x2XHaI0QwPY8
         o6+XDXUy/1fc0P++fzleblDBxij3vcIxbkC0DiF4Bchq921nGQ/SyJWYDgxjFvS6UW17
         z6dVs59QtI1CVuj2zcwW3D+ZvYIDIp8GGtwFKYLH11BjaKiIUSSXjqNtS4yHbY/oy3ac
         nsDvbG29yfLQdWnd7usCNC16bNqYwoYtYGKJEDyedgvw63H4qDaPpQcZ3b1SB9G+EKhc
         Nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161490; x=1750766290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAyN+ToNafItED7vOGd5xwZjLyU6vZgREgdnOsl2nNs=;
        b=q66NBl4rFbi1ZITukFCRgiEQHbVbpYPRnoAoCf1AYeE6sS/SI5PqRUCsDynTB1p5bu
         CWUyShWPeZ5cJ4HFs3qHopOrMX+Hf1rXpBPixdmgH8NGmJAdTYLPuNvJXRJcfMx9mYtH
         h/C/zHbU9DUqZ61lcGOCB3ckY9nXcyxHIRVDwmCNMadis8tZDN4eb10v4BaD6pjkhWiG
         ePIosAZWum0YznZhr88zox8id65dFUKYnG1wiqqh8O81tLVq4sS/qEFhMnm7XpZR1qdH
         MK6ly389WzpAqt/Vn7is41q9casa8aow3xmDT/5qf4SJWbhYp44/A6XXJryR2SeAl68Z
         0A3g==
X-Forwarded-Encrypted: i=1; AJvYcCUkaIHFmTzbL5YOBa/YlFpaHGg0+kTtNZBcs487FxSK5IGV283jTQCSgti9PINhoxV28r6TL9uOOykZv1pd2okmfMxj@vger.kernel.org, AJvYcCXRG2CFtNNaxRl2osPCC6G9IBwpmNLCUe7/QcOYzocigu7vHqNRmD9as/QSU6X4yMsQS8+Ri65c9gZG3V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzrFdUtW1uuFSni8kXSlIl0y15mhjnTDfEu3nYMg60QSKn4i/
	bnV2DQJaSK+PuhDGX5J+N6UoJB1mxb6Gl7j4GWoUudqhqryy8c3WcuDe
X-Gm-Gg: ASbGncvNQv2FCGDj+8F/apR21WpWPOWcxVIVKZgxNYvkgz+vqFPE5MNUmrcU5sNJWff
	mJ3bgdV86iOzmjx9QFKCex/3lvNc5JqiXFQYqBTcYzXcqJ6NZGJjN7A3tSJtHibPY6JJer8Sh1a
	54J/PIEBT3kOfuiiQyRUhiDGvF4TRzelAjrWsaT+Ynif7Fbpg9bnOVO8auA0WIj137oPzohdCPD
	PWyPGGecBlaHy59UGp5TbtSyVKAt2GHvMxGgOxtS6IEs7fUE+Eg/xp6QBQXREO53likivoON+aO
	JYpzfXIe6DiWVYZjlG9OYkixbWAjwvtRtFlkgDuRSDc4i5Tw
X-Google-Smtp-Source: AGHT+IGXnMPgXlA31Bvtqkmp3Vbasv6EcrISFOMjHiVmpzR0wieOBOhr8LT/ICTlXm+PF1m7z7hFmA==
X-Received: by 2002:a17:907:3f1f:b0:ad2:4fa0:88cd with SMTP id a640c23a62f3a-adfad287bbcmr1067904566b.9.1750161489658;
        Tue, 17 Jun 2025 04:58:09 -0700 (PDT)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159e24sm853034966b.34.2025.06.17.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 04:58:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Jun 2025 13:58:06 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aFFYTi4FcKE7rmlI@krava>
References: <20250514101809.2010193-1-jolsa@kernel.org>
 <aECseBOkQynCpnfK@krava>
 <aElE4r21ZYhLWTZz@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aElE4r21ZYhLWTZz@krava>

ping

On Wed, Jun 11, 2025 at 10:57:08AM +0200, Jiri Olsa wrote:
> hi, ping ;-)
> 
> On Wed, Jun 04, 2025 at 10:28:42PM +0200, Jiri Olsa wrote:
> > On Wed, May 14, 2025 at 12:18:09PM +0200, Jiri Olsa wrote:
> > > From: Jiri Olsa <olsajiri@gmail.com>
> > > 
> > > There's error path that could lead to inactive uprobe:
> > > 
> > >   1) uprobe_register succeeds - updates instruction to int3 and
> > >      changes ref_ctr from 0 to 1
> > >   2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
> > >      is changed to 0 (it's not restored to 1 in the fail path)
> > >      uprobe is leaked
> > >   3) another uprobe_register comes and re-uses the leaked uprobe
> > >      and succeds - but int3 is already in place, so ref_ctr update
> > >      is skipped and it stays 0 - uprobe CAN NOT be triggered now
> > >   4) uprobe_unregister fails because ref_ctr value is unexpected
> > > 
> > > Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
> > > which is the case when uprobe_unregister fails (int3 stays in place),
> > > but we have already updated refctr.
> > > 
> > > The new scenario will go as follows:
> > > 
> > >   1) uprobe_register succeeds - updates instruction to int3 and
> > >      changes ref_ctr from 0 to 1
> > >   2) uprobe_unregister fails  - int3 stays in place and ref_ctr
> > >      is reverted to 1..  uprobe is leaked
> > >   3) another uprobe_register comes and re-uses the leaked uprobe
> > >      and succeds - but int3 is already in place, so ref_ctr update
> > >      is skipped and it stays 1 - uprobe CAN be triggered now
> > >   4) uprobe_unregister succeeds
> > > 
> > > Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > hi,
> > I can't find this in any related tree, was this pulled in?
> > 
> > thanks,
> > jirka
> > 
> > 
> > > ---
> > > v2 changes:
> > > - adding proper Fixes tag and acks
> > > 
> > >  kernel/events/uprobes.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 4c965ba77f9f..84ee7b590861 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > >  
> > >  out:
> > >  	/* Revert back reference counter if instruction update failed. */
> > > -	if (ret < 0 && is_register && ref_ctr_updated)
> > > -		update_ref_ctr(uprobe, mm, -1);
> > > +	if (ret < 0 && ref_ctr_updated)
> > > +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> > >  
> > >  	/* try collapse pmd for compound page */
> > >  	if (ret > 0)
> > > -- 
> > > 2.49.0
> > > 
