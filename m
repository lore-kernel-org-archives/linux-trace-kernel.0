Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EA306484;
	Tue,  2 Sep 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836308; cv=none; b=sm2nX4AUXFuhEpn6Wqn81LA9Cw2j1ErpsaVAgNLUMQ1+54mTPDu88nhIupUGKAJNFTqrLAbEEjTIfE+7gPspolnNZJZ8hDOjB5IO+48lxBgGb+4ydSO62ZGKglXKk54PTw2BNcT4kPiM6RcLIT5kpRPWehuVbOlimy2vY2Cle4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836308; c=relaxed/simple;
	bh=vpT2P3exydX6YeKtZHeLeVFc39w1RZ60CDz2GhDUKZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSLExoC5YLeIhZI8guk4LSHs+JTUV3qYdITfbQ/kwNCxhtD7D0Y/b+QNMHLq9E2t26RypZhcGU52dhiivTCmU5yy9TjkQkjtrFnXaYV3J4izoiQj1FBpumM6iC/wkqzCWDLNP+x+G4XpheMHj/Et1C6txysMWeXwnnT6oE1yRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAP+c4gi; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAP+c4gi"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-80a6937c99bso3790785a.2;
        Tue, 02 Sep 2025 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836306; x=1757441106; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIlvD98GkMGtBK+DFLvb23jF6yu54W1IsWgy/W32FDg=;
        b=DAP+c4giJo7Suhx1JqUlLHRx3rk+/q8XO5GfaBl+hYabjtHG8lXDGMoMNP4P24DXTy
         Kw6RIk3etZhWzkjC+7wqy97tmz3lql8QiL/pgTgiLSAuFsgYfnHGN5Qg7AubYj7w5wBh
         2Y26WVORlkZwHlU1dTQVHny/ab+GtpPSlEKvQeVeF4V/85Yhtmz5IXlzeAfTCByuyGPN
         vcqGabgfn2rNZlFMX8kfa7L99EbEGeCLdwqtbRi7NMG4xIWjvaORN5LEAJRuYEHJsdcc
         pODuQZw+pV/ln3efOfUPH0MRRQCntrs18RCBqyUXLbd75zLWtvID0rYEr5COoqrah5QK
         XXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836306; x=1757441106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIlvD98GkMGtBK+DFLvb23jF6yu54W1IsWgy/W32FDg=;
        b=E6eZtLz+hD3gkha+Y0+R43K/GENW2PRTDDCI0SkNqv/uoFtO3yCPYKp8JPQWjJLq51
         XqDwfGvs5uEQ9VsP4kRuvNtVRy+124uWFuwxFeHFGuGwuKvRb9pKkjTlAte3fp9h1zcq
         947BAjp+qUNNVpTL2I+10cxNcffhU6iJ9yPVwnQ0OMDGfJN6UoJGaQg3Y9rurCHia8mG
         2cy0xIIUo107V+w1Dyv5lMYxikDUNk1IUon6XjfzHKmNFIQR+EawUGAHpHdvsGT/VzCR
         INTe8qGKGgcYUuasymK4fFM60pVGnK7vXXE52JYFXpD0J1RluP14hVh20UudSYmG0Bm7
         VYbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Nh1TNqO5D5Ii/zdiEZ0fguQwfiLI+aT/mHKp4IoSQ9agGaAjQBLCTQhjXeHSDox5zprKsycWESU=@vger.kernel.org, AJvYcCW5QBCDrEg/n4WhT3xGHYjWbsJT+OhnJkS3XTkHG19bcA/8SW6h2m98tOhjlA9jQbTdlTKbMrfzZzdbStaz@vger.kernel.org, AJvYcCXPQXrjrfQ96e3aRDXNoVI20nvBApjhs3hW1V4nBvl8JUz4HkRCiATe2wr2/JEsQZ6es8HT8nzloMklgOZ9qF9Lzcx9@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAjxd83VXezzLd4ZXTwQnhOB2HeOMyeeIt3v5SoydrfwSY2Ei
	xGQph8GQCnHTHmgeL5C8WaYvE1J2h4HE9ApAdDG8H+WvRNc4f1HSodNN
X-Gm-Gg: ASbGncvaGb2nE9uT8gNynCcTzrVkJVxmNc1KB/Ds3wJpZl3+jAU/bLaFaWSpvJxV0Wl
	x3YjrBib9jBiAQg6aQl6+MDSWBmLWBkhiSj/gbHSvPj69lmMqgDqEKVeCDf8lFTJXoX6qDetrBP
	CFVl5bDZ1phspL4o1sAWEE0bZjnyQ81JfWkZx+deBcJAXoUGlQf/rfLm+m6TZrFS8bn2XLy1Kz4
	lnVxYIm9httoTT0pUO/NSWt6pjqclwKrsa6J8gn4QyZ7+3s/AJ2xjMdXp1XPhwbAr1PoLqeXw4t
	Ae3S2gR7Pk/4tif7S8Ic7tzexcxeRTr8YaSgQ73EC9mY4iHEI3l+JapSf09xwHX8NihqPODAUc7
	w+GUz1BTZyX1ZwYUa9QzlcFK6
X-Google-Smtp-Source: AGHT+IG33G49UmwxidPwPIQ27msoCdvjNpNqGAldLPbiPT90UJCo4nVgEXSQnnZTEoLi/H9MtlNbSQ==
X-Received: by 2002:a05:620a:4095:b0:7f9:ad9a:1eec with SMTP id af79cd13be357-7ff2b0dc837mr1439926185a.42.1756836305431;
        Tue, 02 Sep 2025 11:05:05 -0700 (PDT)
Received: from ideapad ([130.64.64.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80698720d04sm174129385a.24.2025.09.02.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:05:05 -0700 (PDT)
Date: Tue, 2 Sep 2025 14:05:03 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rtla: fix -a overriding -t argument
Message-ID: <bc746db5ybqt7f6pga243opnh5sn4dsggwerhh63ydv4wk4pej@64effpqdxias>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
 <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
 <CAP4=nvRZ_SY_xdC6N8LkKUA=a-QP5gc5SMgBr4jod6+tu0TFeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvRZ_SY_xdC6N8LkKUA=a-QP5gc5SMgBr4jod6+tu0TFeA@mail.gmail.com>

On Mon, Sep 01, 2025 at 04:23:55PM +0200, Tomas Glozar wrote:
> út 12. 8. 2025 v 19:22 odesílatel Ivan Pravdin
> <ipravdin.official@gmail.com> napsal:
> >
> > When running rtla as
> >
> >     `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`
> >
> > -a options override trace output filename specified by -t option.
> > Running the command above will create <timerlat|osnoise>_trace.txt file
> > instead of custom_file.txt. Fix this by making sure that -a option does
> > not override trace output filename even if it's passed after trace
> > output filename is specified.
> >
> 
> Yes, this should not be overridden, it's a bug in both the old
> implementation and the new one using actions. Thank you for the fix.
> 
> > Remove clear_terminal in timerlat top as it removes "Saving trace to <filename>"
> > line from the terminal and is not used in other modes.
> >
> 
> This is not the correct fix for the issue. clear_terminal is needed in
> timerlat top (and osnoise top) to clear the terminal before the
> updated status is printed, the fix removes it without a replacement,
> breaking this behavior. Also, this is a different issue that appeared
> only when the actions patchset [1] was merged, and should go into a
> separate patch with a different Fixes tag.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250626123405.1496931-1-tglozar@redhat.com/T/#t

Makes sense. This problem indeed does not happend for osnoise. I will
update it in the next version of the patch.

> 
> Tomas
> 

	Ivan Pravdin
