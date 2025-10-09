Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCB252900
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020034; cv=none; b=Tt33AR0CuwdhBvOfHP6DQ9/GxjH1wsNhvpUOpJR+TkLTmsVzBIBrqCP+5HXJCB/BlyAYLtUuo5zI/2pVmbwVfn8PFGYnaw4qwDqwcgXqQeADDMgrPiTDDsUnFt5zrAaOBiNt0h4fl9GbRSB6iQpEt3HIssuJVtujjrOWA0dTDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020034; c=relaxed/simple;
	bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMxpKuPYST/+q0nyXqIn0Msd80zWsncyBYWXfQ83lLfVa+J3y34TUCS6tx6Zchw51UxNYI4gfnpNBqynEN1tUJody46XHB47FkHRAAMI+MU4gf3KfSWkveORtqsg1q8azGwMjOoCLxBJVYJ0Tpacn5OPSJz3wiuypRxcj+imAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbF01AE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbF01AE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760020032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
	b=MbF01AE2fShJQy0fXxT8fZcNZhySLoy705JU1qSPaFB4wpKA4uombld8p8lg4pPgAc1rUL
	PghqG7mmDzOHZOFZimj1sGWlzFWPBsrSgygySWqiLZmvTxdQCFnXQVglJrgp7xcaI8Zpke
	DpwGyl1hce6opOT0TayHvBVjLv1RIB4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-6e-zBO6bONeowfx4dvATHw-1; Thu, 09 Oct 2025 10:27:09 -0400
X-MC-Unique: 6e-zBO6bONeowfx4dvATHw-1
X-Mimecast-MFC-AGG-ID: 6e-zBO6bONeowfx4dvATHw_1760020029
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b41c67edce5so203665166b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020028; x=1760624828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/F02S07YxY/vR+W+qaExDIN6Da+5SzwX0AXZ3uJSi4=;
        b=HncYRIBXJ0NF5sSfbORZzZPCt+eCt86atX+bMsEKv2C2clm3UycSrxQyO/gXGCfYiX
         6HKEwcJrAioAFq3YzrBXzf/+SNqHF8y0yB8o31QmVT7F1VYvuQeWGcPQFF6DIA7CEdP0
         29SLURm5Sk+Vra3iBtPFhTeN+yOfRWQPWgpM70ZYHw8eDwen6v5RPdr90/LwntMy9DsA
         +VtbvFtpEwEyZdHtaCHEUIaPi7zUekgsrjRibCp+4LsrFSP7wKLxweHsF8c5tMYz5j+2
         IO8PYkgf+a0dXd5ulaz8rijYteGJjBBCaJZ4exdR02iQbOWI8GZsDBPWp2c086bzN3id
         ClgA==
X-Forwarded-Encrypted: i=1; AJvYcCWJS2kmjW2D5TzpH5kYDs6Awh9QWiL8oSitHCnPGvEgeGNgoOaZ6iaVB5q8XqBLNo6W4YvqsnqqvQa+D8LuJfEldbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnjZNF8WDKqXGtTbCIKp/F8PCqNbCkyx45UvdeKCkNODHEaZ4
	qA9ihhNl+lUbPiSxgX+1SRr68DDhH1N2amMdDCizRXE75DtwswrnspvVAImR6SUe7oa4tzfr9Aj
	sKtwWAbVzR+8LCVAE7JtuKgQ4eLd268VO05Ofh4WShd6N79syS5dKlQWV1hA2QwLQNa5yOgpMcu
	oX69NrmVmnqyn3SCB1nPbcgh2qwa2JZhTa8oDw6CkryIBe5DE+
X-Gm-Gg: ASbGncuQe1UDKfWbgy7qW7KBg21lKphM4MWwW3Y8Q1I9hziAtAq1ysOnJ24pV7yG24w
	OWKfK2pPCpiMZt8fhAGIyOuig+YZ3xXlJYoirpQoPBoVYNjM338Qm8siotrSImY3gcxp2n2lJbe
	8BHeTywBEkQ/fo+ywOXmm+Z4oAjA==
X-Received: by 2002:a17:907:94c8:b0:b47:de64:df1b with SMTP id a640c23a62f3a-b50abfd6d92mr811671266b.39.1760020028558;
        Thu, 09 Oct 2025 07:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9K4Ovcv1oyU3VJoFriYFnWdSwGIcpMlhvL4pFzCqlwbu14cCZhq1aVRyK7USxJfsD/yZfE8XNTnaHJkha3f4=
X-Received: by 2002:a17:907:94c8:b0:b47:de64:df1b with SMTP id
 a640c23a62f3a-b50abfd6d92mr811668266b.39.1760020028075; Thu, 09 Oct 2025
 07:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTjauRawBPTnGEztZpdDSNhGpgSJtjoTFuq+cCQHP5oEg@mail.gmail.com>
 <20251008184522.13201-1-krishnagopi487@gmail.com>
In-Reply-To: <20251008184522.13201-1-krishnagopi487@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 9 Oct 2025 16:26:56 +0200
X-Gm-Features: AS18NWCYOpNrF7B48EqcyTUqbw_46aTsbs0KByL75_VH-zZNmvaxGmgx_22fbq8
Message-ID: <CAP4=nvQT5xkOCvVK9J-aYMjwqPv=F8bJ6m1yj2W9OcUwwJw+7A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation/rtla: rename common_xxx.rst files to common_xxx.txt
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com, 
	costa.shul@redhat.com, jkacur@redhat.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g6qQwgpDgf1JPyHYVl4Y0ZG2-mjqK4A-hqQ8OT4wmK4_1760020029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 8. 10. 2025 v 20:45 odes=C3=ADlatel Gopi Krishna Menon
<krishnagopi487@gmail.com> napsal:
>
> Running "make htmldocs" reports the following build errors for
> common_options.rst:
>
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitu=
tion referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitu=
tion referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitu=
tion referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substit=
ution referenced: "tool".
>
> common_*.rst files are intended to be included by other rtla documents
> and are not meant to be built as a standalone document.
> common_options.rst in particular contains substitutions that are only
> resolved by other documents, so building it independently results in
> 'undefined substitution referenced' errors.
>
> Rename all common_*.rst files to common_*.txt to prevent Sphinx from
> building them as standalone documents and update all include references
> accordingly.
>
> Suggested-by: Tomas Glozar <tglozar@redhat.com>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---

Looks good!

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

