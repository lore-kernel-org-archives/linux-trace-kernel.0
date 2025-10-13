Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006220F08E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341750; cv=none; b=RbGrswav6+3w1ZoRAczwJhk425peLkk1TFbaHLubyqcycaNcimsuiVEZyoz+wq3u3fP7T6y7NTEJeRqa0bZbsULfKrmH0Ys+eerYCEKKCZFAgcPiQ70QcWbRqKIR1KNWF+heu5U047+CjWX3YGchxST7HrBw9DK6YIbnsW8QqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341750; c=relaxed/simple;
	bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEsQnEm5e5lOEuIBBpWpmbAZyJ/0yBgqmaqvBsKdxnHukgMTOmzZsiRapH263+6ex8MUvGzvq3rfXVNhbfX3C4sUtwvNuOQL8OmVdJH2G6HTyBJzbKPMw0eUGpU+dL74DNz/u/ckgdMXZT96KjofHWSIPDZSie/8dvSi2vJryBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dS4uuKbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dS4uuKbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760341748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
	b=dS4uuKbSm6ZXMG+HnEvDA9GuBQfEXuN/Bh52YWtc+LHyyrVMZ5YQpNupUDdpYgJLVxoSuL
	xCOVR4qW6j0ve/qxzXXPGqYBQt0D05aViK0BqyZ/J7rqzJkOEjtCXAz6U7GbGJvYL5yxIw
	fL1RSntjMi5Njpb92yvDNnkENdAzmqY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-jRElyvArNymPvdW3Jcprtw-1; Mon, 13 Oct 2025 03:49:06 -0400
X-MC-Unique: jRElyvArNymPvdW3Jcprtw-1
X-Mimecast-MFC-AGG-ID: jRElyvArNymPvdW3Jcprtw_1760341746
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b3d21b18e8fso327504766b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341745; x=1760946545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX3zGRqZI4Jml0uk5ubCHiZ727gZMt/y0Ls1cBpk+ZQ=;
        b=V8Z83ztgN3B/173NifWojAcbDFYGkE9nnImQWqum3Yg8NMrtWdC0Y7NuVGYFUKqoN/
         8F19x5nWJ24fw+FN/P68TQfI0nOl7VVpdSHf6b8HZKVjBWQU4oN4DcpOGiRLyGpu4muD
         983RLYhRaVJJYuqOJ/YiDgaOsokJ4trjpzNAfwQpCPruNQk0DKBplQDq3EAZxJWGzUam
         xg4OoBC693+kPKoaOdDCgeVRTp0GuxfUh1hObQK8GwjAzFtL9JDdjCfSOEWyw31WETxX
         9iO1jco/vJyj8HMckze4HqMeAybcsXlYmItUYbE4s4PTlTrtfDtA4+8QkvuCCa6co/0L
         btzg==
X-Forwarded-Encrypted: i=1; AJvYcCUDyB8nkuOJ2wl2VETX0OsmaUHj01qcDECbwl2UFMvvKOQXS1farcKqpqvyQ5CbYguWoULAki6reUdH+AeCvvMD87E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XWgNm2o2JLY2GRKMcSOPtX2hSybzSPflsZDxheTOrO/FINqc
	05rod1eW86AwoyHnhYmXNdxTfd7XBL+xg9VDR2KyTCohdkKKtBQedth691bz+UFII6mEY+gN2vq
	3Tfin/RzinJ1XcOYUmRLNTJhDGMhyhGu7Xjqz+gzOdWottiCBecKy7WLf/ZmJzY6Y8aah/peytw
	zrrTZBVJuR1qwHcA1F5pAp8dvesJTyxWIXl9cxqL/ejnTW33PVrallTiZfc9Q=
X-Gm-Gg: ASbGncumPIoNnUBEfiiMB6LEPpcz8iM+5vyKClrHLvdYcg7bJtEycx9UNhsIau4kjVO
	gBTCC2HBlYppxSuOEFOlgD8XtXlsjYP/pRyamwrXXVnGF4nD/kT29RXd+33s0TrHu7RzsNS7v6E
	9bKbk0msCf3tsYcsgjuI5B8YnvQeBn9Yz4G/lOwLOReIDzw14cm5w=
X-Received: by 2002:a17:907:3e84:b0:b45:b078:c52f with SMTP id a640c23a62f3a-b50acc2155emr2001868766b.61.1760341745276;
        Mon, 13 Oct 2025 00:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqhrIMBzv7FVKIJZY7pAeTJyHF93qi5Y95G5zE6lbLfCze/pnMZ8A5PNK3mFI88ZP8uZpaMEUlkIjGra4JkTw=
X-Received: by 2002:a17:907:3e84:b0:b45:b078:c52f with SMTP id
 a640c23a62f3a-b50acc2155emr2001866666b.61.1760341744888; Mon, 13 Oct 2025
 00:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012071133.290225-1-costa.shul@redhat.com>
In-Reply-To: <20251012071133.290225-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 13 Oct 2025 09:48:53 +0200
X-Gm-Features: AS18NWB8lS_HxhSgQA3ExX7TS8082JQF5u-zIBQhVjx3OB8WMoHRJEDOv7TxcbI
Message-ID: <CAP4=nvSou70FUBF=GTKUziBfV5tXFKLcwgyDwcLmyA4y0PdS9Q@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Remove unused function declarations
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8KVAA-pWZg99JFpbH7XT5C_wimBK3sfrB8f2_MFk27Q_1760341746
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 12. 10. 2025 v 9:13 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Historically four function declarations remain orphaned or duplicated.
>

For future reference, it is helpful to include where exactly and why
those were removed, especially considering that three of those four
were only removed in the most recent tag (6.18-rc1). For this case:

Commit 2f3172f9dd5 ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top") removed
{osnoise,timerlat}_{hist,top}_main() functions in favor of a common
function, run_tool(). Remove also their declarations to keep with
source clean, along with parse_cpu_list(), which was replaced by
parse_cpu_set() in commit 894c29c76b2b ("rtla: Change monitored_cpus
from char * to cpu_set_t").

> Remove them to keep the source clean.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Tomas

