Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989717EEEE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655994; cv=none; b=dA4rLy1/COiiC+Md+GL5slJ38unSE2cWmoUCwg1lk0QA30BmSLbLcDmy+2nezOqAhHqS56T+sZbAVbmOKydB2+tpVr+F18HbOAZ092qfcXgtFGV7SDPg0S1DXNjJZlCQti9sDQTjAyV80WibEkErzk81x5PuvhRnVDEJ4EWPSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655994; c=relaxed/simple;
	bh=XHfQdT5xppI0sxHBN2lXjiAv8/rSbOiPYsD4DbY6//I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE2ghUUx6fqfinUF4LV+aSod9bE9PIQUGozP520EBixlm6nyHheam/ePguOV7NwdC6aT/fM7RD6ZdvYsLwSRJULWZWfAj1sq3EXVcQ2nYldpg98XfiP1BCTSk9OUQU0UDodUz5qZCPnV7FMml25RPs/dQDzD660Wxent72blbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D/64/Do8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D/64/Do8"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a363961b96aso135363966b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655990; x=1707260790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsAQvVSaSL32A30A6uQETKC8YhkCEz/oSK87u+lSg5M=;
        b=D/64/Do81E/DpaWxPWjTFqUGeqlRy077VCdwonWLcyZtGJdzVPHza0DnieLXJ+FxGb
         jFtl1gpH36pKJm4a3CbuBc4M+z1553D/0ry4vjK7ZjUGms6VwggZaLoEqMokWSSTCDAl
         9fg54NfWpr79zIN2eJKuHcihcHaV+elSTXIOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655990; x=1707260790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsAQvVSaSL32A30A6uQETKC8YhkCEz/oSK87u+lSg5M=;
        b=oRndDJqw1dhiLslCmANMB+Yr93PexR9zeorxteEvAtqYWn/WMy9jBpvge3Rb+i3z3h
         3zg3nyibjKGSSitg62BaCERmDOpbQeQ+G2YSv9rHX/Qeejywqdr9c+V09zEUIcriQgYX
         L+0gBkJhJMAYZs1yWn5eZSTZulKaV5GSZ0zfbh0gadAOrA62YpbEw2wp96Q8HGJiQ96N
         RHjzFIbPGxc4n62VMWK6A7wMbNTxYu2MM7WQtrZaiOgNB4O2honAfv5ih4V4cP3gR9qZ
         yqnU4VWFTPKTg5oEmyobRc/kPSTkW/+dx1ErvsNTytyR9K/E5GcL3YFKgW68YqnxA5jB
         rsRw==
X-Gm-Message-State: AOJu0YzI71VC6BV36MeSPgFFR5eaAvVjwI7NuTszw0CqsnA6GG+OSMuw
	67L5wN5nfsRF03wJqKUeLiGWvMZeHNE/YWBP2ptnyoN2ZIa27OMBSRSRShe/tkR31pPDgAtqlG7
	Ucg6FSA==
X-Google-Smtp-Source: AGHT+IHdEw6OSHLBoAlOy5fK4UdTCA+pWbo+Q24KoQhnPPhCH6o4YyLBqzfrynxH7VSuU9nk2Ah24w==
X-Received: by 2002:a17:906:3b09:b0:a35:920e:33e0 with SMTP id g9-20020a1709063b0900b00a35920e33e0mr6360971ejf.58.1706655990554;
        Tue, 30 Jan 2024 15:06:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a36551be7d6sm407472ejd.41.2024.01.30.15.06.30
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 15:06:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so5543876a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:06:30 -0800 (PST)
X-Received: by 2002:a05:6402:17c7:b0:55f:7b91:cbd5 with SMTP id
 s7-20020a05640217c700b0055f7b91cbd5mr234469edy.8.1706655989651; Tue, 30 Jan
 2024 15:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com> <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
In-Reply-To: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 15:06:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
Message-ID: <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 14:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With that, the base size of 'struct eventfs_inode' actually becomes 96
> bytes for me.

It can be shrunk some more.

The field ordering is suboptimal. Pointers are 8 bytes and 8-byte
aligned, but 'struct kref' is just 4 bytes, and 'struct eventfs_attr'
is 12 bytes and 4-byte aligned.

So if you pack all the 8-byte-aligned fields at the beginning, and the
4-byte-aligned ones at the end, you get 88 bytes.

At which point a name pointer would *just* fit in 96 bytes.

...  and then some debug option is enabled, and it all goes to hell again.

              Linus
