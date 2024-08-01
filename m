Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCA16EBE9;
	Thu,  1 Aug 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517682; cv=none; b=CW0564HTa4+HxMIWxS25lij6avuXamFKTZ8tz+da1jKnlOe4QH7QMSKOiszmiMNLfgqZ8kAT5jT/TqX9oPVTMvP65vSFO4Fx3lkn5G+WDQPJune/ucwHgDJaq0LCK21C3X1OwsSZvPlt1jW4PK8n6E0JbLisL8XGYgMlkqwVpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517682; c=relaxed/simple;
	bh=+vSiC2EuaGeftoWu6D0aWBGXxMkoI5tHAyU15Iaw/zU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9XtA7vcsiP4mYj7pp6L7HGoCYjClRNQEN+S7OtNA1RbRPz6gshK/iyI8XkwSAP1GAgt6D7ik2hZNR4MFh/OPiqSUbhu+asX9TOK7wc/z6ioLdvXWJFR/DOSOESvtUgqIKy33FzcPxIAF8lfbpBJYcvIicXtNJz4E01s3SL8sE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcN/X0aX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcN/X0aX"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so3813016a12.0;
        Thu, 01 Aug 2024 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517679; x=1723122479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WdEdlsOxaw/zqPrb6T0qC6gusGe6x4iFHSUDE2k3bY=;
        b=RcN/X0aXE7bmjfAFXNiFLr0AVMk8nNGdW8Rg1X8QNw23nRJybUa5WBHgwp30XDVBaa
         PLuJCi1Fko9Jq/PYZ+9gNCJE8ltfMa5PTFMdx/OJdyUbRpTUETua7EBY+aBM4oJkY8n4
         9ah20zgWkVqnROvTX6GlnesaAZko+j4C1x559H1kBM+tModqaJ275EurRyHz4A14IEOz
         T2JlvhB41Bv+KhSJsBJ/uEZM85lf3LQyBiTrTAu9sjPNVvFz3ktdOQeoRkAy3e4U9f/t
         6RXkOisWuAOSQ5s8Mcqfg/1aDCowor0iIRI/PLPFpuJ6kO3IW9QN3Ff1mIJFrMZ4dXdu
         V+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517679; x=1723122479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WdEdlsOxaw/zqPrb6T0qC6gusGe6x4iFHSUDE2k3bY=;
        b=fDT1FVWi5khGYwR6yiKuvJ+CUoNwNWaB+CyoNVlY7r11YV18iCSzyjkFupiFlrXDfN
         F/KgpT977s3yR5nguhapqadILf6LByHUBl+Sa10d7JtioZ4T7N6iyrJaxozZJLf3FwkT
         V5jn9sjpn9VUlTyCqOHVVMZ0TW6SbYLt/o+ZX4ELG8o+NIEWX4zxZgGdH6U6xLELCHyx
         A+StC6bT3bUa7lwzL6zWkBBShEZSccJrGaFpZUqrXC+h9pyZxRBPeYbgpiAylT7G600D
         AYdowtuxPWJN2afqK0oo05nywGFvftE1kg+cnqdvSOnVXYdZFbAtbfjZOc63T9MfKxqX
         rYow==
X-Forwarded-Encrypted: i=1; AJvYcCVmXFH2F76BLiglA/6Gy2CYuXgUNekNFQAlk/jVWwPhmu/BqLmelThYzsongLT2EVqPobz7M0wzqOBYoXtOgx8as1mmuJ1q983ZBQwTv2uJsAWTMouyr2m87+53FTQ1KbGZ3quqSW21JJW8YnKgsqAI
X-Gm-Message-State: AOJu0YxsBB9FJe+dNhjNFnbJI917RBbGTXrY/WD+1aKmV3BQJXDZKdWX
	U6doRzwhUQ2SSF5eApudyKXdIS9LPohtOxbE64Rea3dqEOGTgAho
X-Google-Smtp-Source: AGHT+IGOD9z3H+UjoRiuhiYAtXfwXvsp1ukvfQ1FKdLtM5oHWJDkTolO2xVdP2nX4oxie4uxwtpmWQ==
X-Received: by 2002:a50:ec8d:0:b0:59f:9f59:b034 with SMTP id 4fb4d7f45d1cf-5b77cf6b5c5mr1163406a12.13.1722517678383;
        Thu, 01 Aug 2024 06:07:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d005sm10102124a12.38.2024.08.01.06.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:07:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Aug 2024 15:07:55 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <ZquIq7h_TQgjBERC@krava>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <ZqtyMTyu3uneHZDJ@krava>
 <20240801120018.GB4038@redhat.com>
 <Zqt8UPBC7zAWDMHD@krava>
 <20240801122644.GC4038@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801122644.GC4038@redhat.com>

On Thu, Aug 01, 2024 at 02:26:45PM +0200, Oleg Nesterov wrote:
> On 08/01, Jiri Olsa wrote:
> >
> > > Note the additional path_put() in testmod_unregister_uprobe(). Does it need
> > > a separate patch or can it come with 5/5 ?
> >
> > I think it'd be better to have it separately, the test is already
> > released.. so people might want to backport just the fix
> 
> OK, I'll rebase and add the patch below to v4. OK?

heh, suggested-by would have been fine, but sure ;-)

thanks,
jirka

> 
> Oleg.
> ---
> 
> From f6bf42015048938d826880e3bf4a318bb64a05b4 Mon Sep 17 00:00:00 2001
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Thu, 1 Aug 2024 14:21:47 +0200
> Subject: [PATCH] selftests/bpf: fix uprobe.path leak in bpf_testmod
> 
> From: Jiri Olsa <olsajiri@gmail.com>
> 
> testmod_unregister_uprobe() forgets to path_put(&uprobe.path).
> 
> Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 86babdd6f850..55f6905de743 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -477,6 +477,7 @@ static void testmod_unregister_uprobe(void)
>  	if (uprobe.offset) {
>  		uprobe_unregister(d_real_inode(uprobe.path.dentry),
>  				  uprobe.offset, &uprobe.consumer);
> +		path_put(&uprobe.path);
>  		uprobe.offset = 0;
>  	}
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 
