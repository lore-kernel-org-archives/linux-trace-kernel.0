Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE621AAE15
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586161; cv=none; b=kOBuAbG5HAFxtGz9b6cObL1gnQU8o6Crki/9CHUrgzVgUq+pJivujiFZH1Kbkcnop9AN9a7dsEYGJTBkUOQPOClbXHN5ORdq7TCKGWqRyEyxReUXxETPVs0Z5LHlG6cHTmhDILBH41BjeeXiV3zjnPg7b5UVbGQA4RDIC5tx1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586161; c=relaxed/simple;
	bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpLMjcHiWs4KhVfK/pZCSJ5u/V8oGfZGzVmBxKtxTHFBlTxECM1TbzrUq4bFTo69dxMmP7RKgyhFVpW9oTmW3T8EC5ChSvQkzFrmx4IqP/nJ1XACCQZDI5s37wgOGH38PB92goKhVGEiCZkSoWbrqvH4gaLmnoKekWHGxc32bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IelEeAII; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IelEeAII"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-493d748ba72so2174205137.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723586158; x=1724190958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
        b=IelEeAIITogoo1SSJngz6zvknUJ23IORg0IIzoNgFQaInn6XdLBzk3zjG6skLppVPM
         gZuMdKd/IHfJezdOBdq1BSQtiDM0CLhxEcc2hgTtKMejxIffJwHmHz+xlE1l86gD4sHi
         BUt3LKrCBzkF/D5vnqjm6MpaE0ZHecrjK6xYAs0ycZG6Lnoo1AsyNMjLaSupNabxxVvT
         r6q+UU2ooXyoN/YK2K5ekvlNQVWnA1QrxZq/xIT0ubLDLqA8f74xqG9ELIcgtUovxR6j
         kRmtZf8oyWzEdk8Gc4dvAAcY/wmx13wlTJ0qiH0eT2wASvokQUYp9un55joVbGb0KRYO
         sVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586158; x=1724190958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
        b=mDPTtAg4fLJkLn/rZvrjE2tPqeYDcjR1c1PPH6c/BnzAFOVq5l77rADHXNe/51Ak3y
         eGW4AWe7cBJKFD6Y2z6x2pb+Q+LnRyl7PfFJ90HIL8v1ewKd3RY/Qnb5Eq/su+Qx2ay9
         zU4R8Dt7gC2gnh/29sv7kzkPCCcTBqFkRLIJNcVB2ohk0r9cMdVJ6zTr0XVDLdGL1WcP
         ziRIrY/UXhGGpO4fDXVG3UR81j88wJen7nH8Rg75Wh2jrVCf85+WarQm91WnP3gHvNs1
         iI4pcLQj7gx8slCJka2N2kPZX2U69J+FZWRShb5YC8xa2ia3bnZOFn+WSS74Hdm7Mgcm
         BmqA==
X-Forwarded-Encrypted: i=1; AJvYcCXeXdkYhxrB6hShbVvxHMz3XPR/uaap1u2VflID/XvBLg4WfhLeJ44C7XEr4jr3q/FJN3/uImmqBICWbOJOBPtg7BrohZ4SnVOT60UwqWwFfTfL
X-Gm-Message-State: AOJu0Yz46i9v4iziqZg9xu9diYTPAWen+ODO1JrHjSAYb8C+6oVXMszA
	R1T7xIy3ubCJe2TAFjkIhvr0M/OXa9FWWamlPk98+OTPEQ9iciBAZOx9G3yPnCjWMlPeJZ3y5OK
	AltiQ+uxm4ZiYfl4um3peTGcTqp+Qkxpsl0ib
X-Google-Smtp-Source: AGHT+IEQaFW6VTjl/NN5Addyayq2vESbO77ln4J7ElHigTL7AZmOrMHtx/th7RP9aYyJh8HhQcoWsHroq+JpTV9PMHI=
X-Received: by 2002:a05:6102:2ac1:b0:492:9adb:f4de with SMTP id
 ada2fe7eead31-497598af685mr1378119137.5.1723586158313; Tue, 13 Aug 2024
 14:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807220513.3100483-1-song@kernel.org> <20240813132907.e6f392ec38bcc08e6796a014@kernel.org>
 <0C1544B6-60CF-44DC-A10C-73F1504F81D1@fb.com>
In-Reply-To: <0C1544B6-60CF-44DC-A10C-73F1504F81D1@fb.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 13 Aug 2024 14:55:20 -0700
Message-ID: <CABCJKudPg+5Q3Y3H7LVa0DmN8ARati_oREVUqsLSvQpAgE5hWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix kallsyms with CONFIG_LTO_CLANG
To: Song Liu <songliubraving@meta.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Song Liu <song@kernel.org>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, "mbenes@suse.cz" <mbenes@suse.cz>, "pmladek@suse.com" <pmladek@suse.com>, 
	"joe.lawrence@redhat.com" <joe.lawrence@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>, 
	"morbo@google.com" <morbo@google.com>, "justinstitt@google.com" <justinstitt@google.com>, 
	"mcgrof@kernel.org" <mcgrof@kernel.org>, 
	"thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "kees@kernel.org" <kees@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "mmaurer@google.com" <mmaurer@google.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 2:20=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Masami,
>
> Thanks for your review and test!
>
> @Sami, could you please also review the set?

As the kernel no longer uses the Clang feature combination that was
the primary motivation for adding these kallsyms changes in the first
place, this series looks reasonable to me. Thanks for cleaning this
up!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
