Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F1478E5E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629984; cv=none; b=lwjwKAe9kkXvz9+ziFkSXgR/CDexP3vvlDxlejTALPiHrEgHKudnRNRqu+nVt9rth4quFH9vZGq1diiOasJfyYHYZl8tTcGlVz4neBFf1p0VKOdGI4prn83KWZOG5RzZUpNsQ0h+llCY2aSIY2jn5Up5k/QsHia8qm2lb2MwElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629984; c=relaxed/simple;
	bh=RCsaeHJjOL3eThI9TyXhwUDgnmspmgSKZrl0n0eh+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmF0E5EhWVryyyz/5SRkAy7KD9XzPFHMtQ6cYBAnKOq89m6uf+TzutJnCLZkNU8gznIQAziIbfzb3MwHKIiY55JX1eybmCUxFUPul57xuphzoXaBmXO7mweKI89yoUSBG0b7OlEqpRe9kAg1wmqBhzvowkm71v/abdIXWkVzpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/2mNSbg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/2mNSbg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fe89fb333so1251084f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786629981; x=1787234781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RWFekVfVDh1uRsmRT6ByR+FlOG/JDoV1UHXYpOqNio=;
        b=G/2mNSbg8u4tW9A43uaMJvYwhN8354XbUAY+SpCfptRAH1MAqWgW30IO6CDvDi+6Ri
         VnPNJ3v04gYCjEpNci4hI8+V4bX3/cxt4n6RRz1uuiJ4Y0q8i2Scmi75WlWM4X4iImIo
         R+gIlLSPKvj7jbwYFVaAMmV1bQVG4K3Aqe8sIp3eFiZRWzanVkjr5o6QdtH79LcSGRUH
         1Zqi02DmO5xKuS0MFxnSW2FTVajvuu6kPY5n3iugsl6Gfu3hmodTOgxxr2eUA77sdyiN
         L2Tmm8oC+Ghw1ljefL5ZAG80qrjLIw5r33K54nJU+OYOg97E3ExhCH14ZB0SQNuQ0Lc4
         YuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629981; x=1787234781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7RWFekVfVDh1uRsmRT6ByR+FlOG/JDoV1UHXYpOqNio=;
        b=NIEj2icAFdGlPXlgq6SIWmyEn6kWqQt1AM1KZBi/7iu+CuXqi+0mvGhWp/JCAN13f3
         Rdw5K3B0veKxcxys5K/Jq6e4ncBLehLFu3BGYaTlk2HADYZEW9AqO0j9BAjcAsSSJC83
         NXRzBRfp0UzgAynuFNRXPuj0NkVk0RA+Zv7ug/8rDwx6L53bTMvyiDyOl76CqlJNCUn0
         KNmP/Al3Zud756wN7Ch0eIVRgsY8I+XaySjUHcE2gksZDl0c9tdSKpYlU+HPs+Eer2z5
         bHwhxkDqm5GtXaeTr6ge6LCuqNDrO+LDtsCcrZL8GrG66dCyve5zc63zBoGzxFEpdlaC
         BrPg==
X-Gm-Message-State: AOJu0Yzal4mvchzPCCa3cBrEqowcWtMun+mQQp28kdu01q1wmbXby6NV
	Ydv8hGQ6Jq/NtQBrw6cpff1DyV0pce2D9WY7solcFW1dfOLSGmAvGReW+6GFE4lFG0AC54SehLA
	Zm/ZVsw==
X-Gm-Gg: AR+sD11SH8tHsAfPOWyG6eCmKLayap9okxZ8lMSUx3zXplvv3KQA7xT6JoxB6HIflIk
	YeTQwxz5ivTO184icJeVOF28h4kdOyg3aBtGc3lROwsBSHu8mma36C/9YoULQ9L55Sy5gh2ANcR
	tE/JFtrWtIZD3PT0uck7q/PQyu1B8hge2k6J43x0aQfsP90EO/ltzB7OmGEUBcnI948vX9h/bJQ
	coF6GErt04vtxM7ENDMqVYUIxEHWavzAScfVeOdWBuoZ8T/mixwHIeYCKWWFcIV5H5gSPadS3hK
	AWRt+Wz9poVA7Zd4TtNZYUQA7h2wQSsAOaCHOJ/p7D9xjjPdxeaGDIJRL3Eq0wc1ee21zwel1fp
	5cHib20lidn0iNCqE7ies7U1eiGiAhKb/ASlSkikFkSvVFSBTopFz3bh1ouj4bdHb2wV4HK/PAG
	p+vYAsJfQ0gKxbGW3GUbL/Ilf5hyPKzNawiwLT+NKgSdkusO23mZXKvavnKw+CsqpyFJShFVkNF
	4jkYkm/KWoaskCP5B1/opEQWPLAWNBZ
X-Received: by 2002:a05:6000:25e7:b0:47f:fe45:e597 with SMTP id ffacd0b85a97d-48159ca60e6mr9068872f8f.3.1786629980214;
        Thu, 13 Aug 2026 07:06:20 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56981csm6901323f8f.10.2026.08.13.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:06:19 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:06:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/18] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Message-ID: <an3PV-9CVSSj1eyb@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-8-vdonnefort@google.com>
 <20260812164040.19F761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812164040.19F761F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 04:40:39PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Medium] The test script leaks a temporary file in `/tmp/` if the test aborts due to a failure (e.g., when a command fails under `set -e`).
> - [Medium] Unconditional write to the new `dmesg` tracefs file breaks the entire remote trace test suite on older kernels.
> - [Medium] The new `dmesg.tc` script lacks the necessary `# requires:` header for the `dmesg` tracefs file, causing it to fail instead of being skipped on older kernels.
> - [Low] The awk regular expression for matching dmesg timestamps contains an unescaped bracket, unintentionally creating a character class.
> --
> 
> --- Patch [7]: [PATCH v5 07/18] tracing/remotes: selftests: Add a test for the dmesg tracefs file ---
> commit bd86167985384496571cc5a8f03ca97dd77d76fd
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: selftests: Add a test for the dmesg tracefs file
>     
> Exercise the newly introduced dmesg tracefs file that turns on and off
> the dmesg redirection.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> > new file mode 100644
> > index 0000000000000..9d389f9d0fb78
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> > @@ -0,0 +1,81 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Test trace remote dmesg redirection
> > +# requires: remotes/test
> 
> [Severity: Medium]
> Does this script also need a "# requires: remotes/test/dmesg" declaration?
> 
> Without this explicit dependency, running the test on an older kernel that
> lacks the dmesg tracefs file will cause it to fail abruptly due to set -e,
> rather than gracefully skipping it as unsupported.
> 
> [ ... ]
> 
> > +    nr_events=128
> > +    for i in $(seq 1 $nr_events); do
> > +        echo $i > write_event
> > +    done
> > +
> > +    sleep 1
> > +    output=$(mktemp /tmp/remote_test.XXXXXX)
> 
> [Severity: Medium]
> Will this leak a temporary file in /tmp/ if the test aborts prematurely?
> 
> The script is running with set -e, so if a validation step like check_trace
> fails, it will immediately exit before reaching the rm $output command.
> 
> Should this use $TMPDIR instead, since the ftracetest framework cleans it up
> automatically?

sigh... I have s/TMPDIR/tmp/ temporarily (pun unintended) to debug the script... 

I'll fix that!

> 
> > +    dmesg | awk -v ts=$last_ts '
> > +    /^[ *[0-9]+\.[0-9]+\]/ {
> 
> [Severity: Low]
> Does this regular expression match the bracket as intended?
> 
> By failing to escape the first bracket (^[), this creates a character class
> that matches spaces, asterisks, brackets, or digits instead of a literal
> opening bracket.
> 
> Could this be properly escaped as /^\[ *[0-9]+\.[0-9]+\]/ ?

Sure, I can escape "["

-- 
Vincent

> 
> > +        t=$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
> > +        if (t+0 > ts+0) print $0
> > +    }' | grep "selftest id=" | sed 's/^[^]]*] //'> $output
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
> > index 05224fac3653d..4a14aa72fdf09 100644
> > --- a/tools/testing/selftests/ftrace/test.d/remotes/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
> > @@ -8,6 +8,7 @@ setup_remote()
> >  
> >  	cd remotes/$name/
> >  	echo 0 > tracing_on
> > +	echo 0 > dmesg
> 
> [Severity: Medium]
> Does this unconditional write break the test suite on older kernels?
> 
> This setup function is used by all remote selftests. If the dmesg file does
> not exist, this echo will fail. Since the test scripts operate with set -e,
> this failure will cause the entire suite to crash on unsupported targets.
> 
> Could we check for the file's existence before writing to it?
> 
> >  	clear_trace
> >  	echo 7 > buffer_size_kb
> >  	echo 0 > events/enable
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=7
