Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38472673B7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982720; cv=none; b=W2v3zFN4pt1A9kM27EZG8Ur99R7zcrpZIRTg3umtCsOXOolYVFOWV3M++02PmN+4Rho+aCeGy+Lcs4choJlHP0L01q2NdUCqI18zAFLkZb63A+BAGbJQXsqVsB2AwhC77WRaBTr0zgxs3KC/mDfCcYGOu1xPV4vq+cIxKrVeD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982720; c=relaxed/simple;
	bh=9HS6TaIn/0Tn2Jw7U8WCQk/SNn+EasHbLO5gxuWf1cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBxgBGN86GDonfgy8H4ZNit1XzH4Pb6oyvE3lxNGESEO3Ix2ppclOiNQ9g8ptX7F/0t24FAON+j9G64jOERRjCXclgnQYaXq8CmI8G/SyR9zD7SSsHoQEl6TgApbUZa7OZg1elahnRc3bZx4D61HtAXahqK6OXz8VX0ngVc9Az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I72jGfj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I72jGfj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760982717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1r2ri9GfT/fD3qpGlgfLRcS27Id7OZXxE5K85HB+l90=;
	b=I72jGfj7DkSmt9lzbg+aW+kJ+iPu6dPuaadU2cyhS3fnAu4ZcvnpfPVQyk0SM7rSvdK35L
	rkQ9mSN583FV1uuJ6tzUJ7ZWR9v8U8q7wuCLZhPw763nAT8N89NOPxhQfOHs/joNpYhVG8
	W5pt03HsjxL3g4nerMqRwLc92otxNUM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-gP97JykHOmmBDBMIuHhM5w-1; Mon, 20 Oct 2025 13:51:56 -0400
X-MC-Unique: gP97JykHOmmBDBMIuHhM5w-1
X-Mimecast-MFC-AGG-ID: gP97JykHOmmBDBMIuHhM5w_1760982716
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e347d2afso506861039f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982716; x=1761587516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zixpkQdeW53Ziw6ehz+7cd8zL/NbyToKZVA/ovjsiQ4=;
        b=deFK9h+ZXSCDuxfEINJlEuLxf+Gspq/G+i6o9yD4GOIas1PhO8gR9bp38VD6l+M2VF
         U+LLufwzqL3cUSgZOht2WPSQ/AnFXXtGlBnzZnmYkosKQQyj+Acp7JM2EfNitoZjTm1Z
         YzaGQWPU8/+nlSDHr9RlLK3nrPdDk1P+4k/0iUKBHlNnxTgZdN4PzdTRpLe//G4MK7wX
         IuCEsl4PmlH2kt9inftHvomx1bfq7hD4v2Fp16PHi76Yj5hQjoNhL2+ovDLOFbH2dTMO
         CppbocBcfEu2x6/LmXZBn4uQxfJZV4P8DepKFvOPTuRmD/TFTr/+B3gPMdziU3tuPw7B
         6m5g==
X-Forwarded-Encrypted: i=1; AJvYcCWCDB9lDKvTr7GmzvIS83c4zR6/lFc977hVVE+qU3Hvh3a+We6OMqsCWjUWpWgSDBt4zQC+UO6H19btZUN2EXsr3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnFl9LUDeYi5BpTyWU41Lj3CwID7pEBohORqCeQvoJpIMNlBI
	7GZF+8Nj+UtPZ7NCpC6EIFRsOB6xLIt497J57a6FRMCuC14ISQXVoI6zwLO/gduqIWSTn1cRLI8
	R6pDZEve5IctzC2o3mxdfIRuZOPiibcB+65ZAxkuypA5EBjO8uUljjXqOxF5qaeWcYOStIN1Hew
	==
X-Gm-Gg: ASbGncuNvt7/j3yxgHyygkiCik3nyv3kx4cG8TUDQiTaT1f90LIhbCm4yWuCZaUEnae
	rLWa71ivuFq8znTzjUL2Ild3gxLyl2hs7c8vCgm2uZBWTY3FwAZFOvNn5WQEaTQH99TKkWRmgcE
	FCiG13qtWDPVXEIVzLLL7EIAbv80TlDstGs/wVtlRw46Y4DW46A3cGygL8InXNpiCMb9N9mu6U5
	tfT+AEFRtq+1VKGH7ujDTCYuGkeakPeJ3Es0FcnfdGDEIKuY5EUMHWgeRLxyxdF55ufZ3h6jfaU
	KR0vBZjNr5VAsRT6j1S1Vj/lB8i6snUYubo6DdUT3hVAM+o3MOltb/nmEEREhvEA6h/OMrUjvc8
	WlKDBhDmRzzG38iaN9fP0b1DHfYnY
X-Received: by 2002:a05:6602:27d3:b0:927:bb0b:3ac5 with SMTP id ca18e2360f4ac-93e7644a567mr138665339f.15.1760982715682;
        Mon, 20 Oct 2025 10:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyz5HfZXSCeXqA0kQoKsN3dOXG9qM7Md3dBC/sJ07LakDX8QnQ+9aJIfFVeYPOL3djFS/IsA==
X-Received: by 2002:a05:6602:27d3:b0:927:bb0b:3ac5 with SMTP id ca18e2360f4ac-93e7644a567mr138663039f.15.1760982715271;
        Mon, 20 Oct 2025 10:51:55 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866cb276sm316709139f.11.2025.10.20.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:51:54 -0700 (PDT)
Message-ID: <4bd0779b41a1e635d6bca738ba2d15ea708a03f9.camel@redhat.com>
Subject: Re: [PATCH 2/4] rtla/timerlat: Add --bpf-action option
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 20 Oct 2025 12:51:53 -0500
In-Reply-To: <20251017144650.663238-3-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-3-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s-ndoMOCzQJTc6edKlq4GFIUs717hEyKcvZkrIktvmM_1760982716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-17 at 16:46 +0200, Tomas Glozar wrote:

> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/s=
rc/timerlat_bpf.c
> index 1d619e502c65..3c63bf7aa607 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -7,6 +7,10 @@
> =20
>  static struct timerlat_bpf *bpf;
> =20
> +/* BPF object and program for action program */
> +static struct bpf_object *obj;
> +static struct bpf_program *prog;
> +
>  /*
>   * timerlat_bpf_init - load and initialize BPF program to collect timerl=
at data
>   */
> @@ -56,6 +60,10 @@ int timerlat_bpf_init(struct timerlat_params *params)
>  =09=09return err;
>  =09}
> =20
> +=09/* Set BPF action program to NULL */
> +=09prog =3D NULL;
> +=09obj =3D NULL;

They should already be NULL...

-Crystal

