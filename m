Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31197500963
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999292; cv=none; b=Jkt4sw8HT+3aunNt6kbqjS+VwCe+C+h+UfJGrOv1ihpIgFSbfemBjJ7NLk5C8MzjujEnLZNSN50m0LGckgmrSrc8MuMq9BxCHBvYOVdQKubZ91Crhx4SQ72Hxhn1auVC2/Ji7PqEGO0ACXsquvT1N5enCLZfQrFRZ8KuOn2BMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999292; c=relaxed/simple;
	bh=xERkOYYRZNLw4Qiqk357RQ12FHYtjgFj7OrefWApWbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKB8CgUhfcrUR2TmMBS4SuZJDS+b/ruKeaN7e2tMnUAsj+ws2Dd17dtk4FRMVKHf+6oy0h/t53Fz4RVZKxQ59MmslXyRnvd4m3IwOJFYnmjD8aX088yIO3xgwLUdqxOTYW6qREmkG8SkBQ6Xw/W1wlTC9Jp4NemQZN7mFIfuH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxWFSZpi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxWFSZpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768999290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZscYw/bdxhOj6OiuBNSLNewOQCrs/JE6NjKF/kWnkI=;
	b=MxWFSZpiXqwMwnW0Tz/XxBggqeVGkjPtxn9DukUFl/VpdqV6w47V6xe5RJt71T3yTeFm/m
	1USkAvVKNrDnyK19GT/8uFvgwy5bhodGH1mM3eN58F/ew/wFPkfpSKqHst64+CE0iOS71P
	kiHc19+Rm9PXRDFag/LooCJeZDERD4A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-XNhna1l4Px6H-zOu_fOatg-1; Wed, 21 Jan 2026 07:41:27 -0500
X-MC-Unique: XNhna1l4Px6H-zOu_fOatg-1
X-Mimecast-MFC-AGG-ID: XNhna1l4Px6H-zOu_fOatg_1768999286
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-382ff90bc44so38571141fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 04:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999285; x=1769604085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZscYw/bdxhOj6OiuBNSLNewOQCrs/JE6NjKF/kWnkI=;
        b=dL+YoVoEZs7KrLpLxWbAodYBHiSrRqvgrvPCsfaYrrWnipORsDZ5NkD2lIqfb53bd1
         bTApEqYGtvdXDs8LkyBurSh0QpNDQkc0R9O+/OO9XWj+DmRmt4iCVJShnZTua9BrbUBl
         SiwuaW40TV3yjlmEAx22/aXJsmfdOk5STUvLH5TPl+5CbRwV07C5xlMChu5D7nDlp2UV
         uaNBKCob22wg87pEptIT5qvRPp4sGnSB9zjqyakK+YZzz0tXpf2+WaiA86ntDak402/k
         3j+99sQ60Q8R55byajYk4KWNZxL7U5RFsA7XhDjq2n3Q4YYjzHfW7H54eKc7ATpkWhi5
         Vdgw==
X-Forwarded-Encrypted: i=1; AJvYcCWr5efAo3F+0nqMvY0vagBk5hBFfUxHnlpbmswni6PSLm51SO7FGu1SFSHWh8hNqPIDEY4yiAudy/0lLeyROgNNhPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEwy3XA2iikAJWctplRv4SHu8GZ1bAVDJ84JmnOpnETp1ldzq
	xYuJOwOIveYuC3Wo9MGwE1w+qtu9evu0gTQvmRKVHeefrTmEz2dG40zLT+eS9RZcfu+IvDOAxQR
	a0OMd4b+TIgnN188yXqFVkQbyrt9YJPcNvGZ1IOImXX7VVf2TT/vY1ja7rmVjFacGiYJ76HQDTz
	nbMMgYRNjPAU+KaH1qzhD2PL4BMgzjai9OEzsHkEfu/znA4JcI
X-Gm-Gg: AZuq6aJ+4iT0wbb9Bz3yERNLeDxV1Gu7hAaDPgALzcgyRukMd6fNgFR+3sVWGeO5JYM
	rph75Sw2sI4kWwTnPvjtVSYh9kKHU5KqGtpBoPTUqEzjkWGCmsdEurgjO0NqU3mLJxrowQL6AEi
	Xn9WqKP44uxcel5ulCWdqKgyM3Cjgh5CpNMZsrmS2C9RmMBGS0R6XAURUfyP60dnPFVjcQKU1Fu
	Bm4DmCCa9ETmlvo4WOt31wy2c7yI+xdQUvhNV8CICuYut+uQdmT3NN1763rC+8tKf1Jxw==
X-Received: by 2002:a2e:bea2:0:b0:383:20cd:52fe with SMTP id 38308e7fff4ca-383866fd63cmr63881051fa.17.1768999285417;
        Wed, 21 Jan 2026 04:41:25 -0800 (PST)
X-Received: by 2002:a2e:bea2:0:b0:383:20cd:52fe with SMTP id
 38308e7fff4ca-383866fd63cmr63880961fa.17.1768999284957; Wed, 21 Jan 2026
 04:41:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119115222.744150-1-tglozar@redhat.com> <20260119115222.744150-2-tglozar@redhat.com>
In-Reply-To: <20260119115222.744150-2-tglozar@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 21 Jan 2026 09:41:13 -0300
X-Gm-Features: AZwV_Qji-TQ-qj3rXF0k0hx6xbP8ozCa6Zg1i682ZANjMPqiFs-GfgUKeFxl3jw
Message-ID: <CAAq0SU=e1A=pa=J_E_sC2M9XsDAjpwDM3wC+jH378Js1UdYGjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation/rtla: Document --stack-format option
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FvZkyowBIoZxx7rtFkylyEcxg-nRnlTNPT-Op5MBOVY_1768999286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 8:53=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>

[...]

> +
> +**--stack-format** *format*
> +
> +        Adjust the format of the stack trace printed during auto-analysi=
s.
> +
> +        The supported values for *format* are:
> +
> +        * **truncate**    Print the stack trace up to the first unknown =
address (default).
> +        * **skip**        Skip unknown addresses.
> +        * **full**        Print the entire stack trace, including unknow=
n addresses.
> +
> +        For unknown addresses, the raw pointer is printed.
> --
> 2.52.0
>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

