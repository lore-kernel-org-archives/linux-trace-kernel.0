Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656A2E1EE0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254186; cv=none; b=mfz6aCoQKfI+Gdl522kWRyvpIli71XuBz8+TjhCVMQ9HVixD9O/uK+PGCkZHt4lHj9Mai9UJcorqSU1Nuo2cZzDOiIFjiCSy4lWlct/eml/uLvOIQLL3s/nwE40cGprA3lgIRFMjlecoVL4jhsJppQvqscgzBVehMYVTpeIAsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254186; c=relaxed/simple;
	bh=E1XqDfdt3OjDrHfrS8ttN1cHp4hIDV/ezswXPVSmuzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEzeq1TdqIiEUkbCH6f93Bq+TiC5suNmXn+ON+lB45yFA1IeymoNSWCFwrumH9GjQzCaq3np4+pcwPYlnKHoNRcf/DThvgvToHNjeX5dx8ipqOrTUr60XNZTTqbt0b1P9/gmurT1EAtgqwikEYAtA6/b9zgviJ2cmZ8GP3ZZvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrymBp4Z; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrymBp4Z"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso13292695e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790254183; x=1790858983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTViH/28rpU6lxn4+eKFogmj0p5WIz5+TiBeTOUOlBA=;
        b=UrymBp4ZnoB8VEkqmf4Jc/WS/bkg7//H1I1Z/Aw8Cs+ElWtwp+tOJFsGchA1HbIae7
         sGlL2DHFrH3k4IpIgPlayIQBBkuMXDt3GsWeXZSs3uOFW36Wy42VdTK6D7cFTS1rCpKE
         Ngl1ftZzxGEjAj95wMZ3bCH6y7VeI2lhnxRi3B3O9XoknOX/X1G2cgB60vIxdMaC8cwI
         ZB3myH9dxbFnK66MFjS2xXPWVQpEiM/btN1EjhFbpXCkGg3D/AEX5QZJdfEp1DrLGHxi
         Sl4v6LWHTb6Uoc1zIbPMQ3vcbJQarDvacph8WuU3wbTNXsACMrqWJZDU4tDMQL1C95Wc
         gDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254183; x=1790858983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fTViH/28rpU6lxn4+eKFogmj0p5WIz5+TiBeTOUOlBA=;
        b=rn4ORFxZmMsvzLNdUkW0Q4X8vCfg7rrI/N1weJ68bjGH/vBe1DTN8loITCKxYCw5rR
         tgImFNKXBWxu5EZmXzLbki3Hho03uvi0au1J2iaPXpmOq5Z2wCHPjSrAs7E3/Y9+oiZM
         A+Cxdxgr+bTEeXSuc0RNfnp6vyh+SMJg1Jya+VaOsn6wKY0YOn/1/UujdjPoRWgG3rd/
         UL8X2VasDMWL8Nqhg5gzsGgJ5neBCS1d2B9ThUByv8U9QbDFXryOKsSAqGad+1H49ZFD
         8tc9Y7eCwMQu43jnwVbAivR1d11EQ+XByPIwPOsKc1agalkZK2/rs7zcdOsnJa4NhMOm
         WwsA==
X-Gm-Message-State: AFuF++nF8XKllLocDlzC2k07WRaK3Q/j+vukV2eQiwl6D6QNnQWzSVqA
	dgiq21y7CcwIkln0SGB+KJW0U8/vm67wPV0RKea6WU+jGTmvP4slM2ZGkhFvrhcjpTjvEbxXrg3
	S+gbbDw==
X-Gm-Gg: AYBFou1CLJbDMOc85E0pRpldi6yoIg9uc4b8BxJjf+Y9fe9wS2xhNaL/jUoYiWoJX7E
	qRBbO/oLNqWUpd+RXiXV6UaYOViu4HgeDKDZaI+2fO8PyyC6VJhGM92AypqMggV19B/igSkss11
	kmKqCnMhYKwQrwmtibY/y/ckW1GsvNDij/tFhihfTZIHAi40X3kM4y412sC+BwzQCiv2WK73uOe
	duvbVR5ypPD6TY8YnsoQdF+xAAwh8Ylwvv9oiQJiMYPrM4V/SU/pJ0kqabnj7ZKuA23e36nrzrj
	DkA582PEyIM+jy7yPrdNOjIOhUFJyXmE2TintWH16GUFqtbTn9iySchwgXxQWOD2pNdQeYSVBBe
	GTdaXROpIItnpUAaLGl+qFKkSjAIQOY1c+SQEcjNlaen6SiUqz4cpnr0o2TKmsAXyqWL/UMq9mY
	2ur4Y9WBW9basAmNGXVBeMRvvto2qC0tOvlEaCVsd83hMlTej8kE+mbUzDdNbsuOq7Q31GRsNKB
	oFCOrelXMDe9Sg8UPdyUZr60XKLuXEQe7dzLm1wKjQ=
X-Received: by 2002:a05:600c:198a:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49fe66d2d24mr43567915e9.10.1790254182845;
        Thu, 24 Sep 2026 05:49:42 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5debbf4sm78220995e9.9.2026.09.24.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:49:42 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:49:38 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/18] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Message-ID: <arUcYmwpk6Jo-_nL@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-8-vdonnefort@google.com>
 <20260817140514.DE67B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817140514.DE67B1F00A3A@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:05:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Unconditional write to the newly introduced `dmesg` tracefs file in `setup_remote()` breaks existing remote tests on older kernels lacking this feature.
> - [Medium] The dmesg test implicitly depends on dmesg timestamps and silently fails if they are disabled.
> --
> 
> --- Patch [7]: [PATCH v6 07/18] tracing/remotes: selftests: Add a test for the dmesg tracefs file ---
> commit f74a3f691a6b4375c6156c109a1d6336670de341
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: selftests: Add a test for the dmesg tracefs file
> 
> This commit adds a new selftest to exercise the newly introduced dmesg
> tracefs file. It checks the ability to turn on and off dmesg redirection.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> > new file mode 100644
> > index 0000000000000..74f801a5e39ea
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> 
> [ ... ]
> 
> > +    sleep 1
> > +    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
> > +    dmesg | awk -v ts=$last_ts '
> > +    /^\[ *[0-9]+\.[0-9]+\]/ {
> > +        t=$0; sub(/^\[[ \t]*/, "", t); sub(/].*/, "", t);
> > +        if (t+0 > ts+0) print $0
> > +    }' | grep "selftest id=" | sed 's/^[^]]*] //'> $output
> 
> [Severity: Medium]
> Does this implicitly depend on dmesg timestamps being enabled?
> 
> If the kernel is configured with CONFIG_PRINTK_TIME=n, or if the user-space
> dmesg utility suppresses timestamps by default, the output won't have the
> [ X.Y] prefix.
> 
> The awk script strictly expects this format and drops lines that do not
> match the prefix. This would result in an empty temporary file. Because
> the script executes with set -e, an empty file might cause the subsequent
> check_trace validation to abort the test.

I guess I could check for /sys/module/printk/parameters/time ... 

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
> Will this unconditional write break existing remote tests when run on older
> kernels?
> 
> Since this test suite frequently runs with set -e enabled in the caller
> scripts, if the dmesg tracefs file does not exist on an older kernel, this
> echo command will fail with a "No such file or directory" error and abort
> the script.
> 
> Could we check if the dmesg file exists before attempting to write to it?
> 
> >  	clear_trace
> >  	echo 7 > buffer_size_kb
> >  	echo 0 > events/enable
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=7

-- 
Vincent
