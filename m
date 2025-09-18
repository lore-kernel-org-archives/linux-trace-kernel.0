Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45624501B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185253; cv=none; b=rp24YXTBZFJd/WjkjALA5ew5iGrUKjpYGxO4qqFSuFczNFyAAjS4AghBxqVb01aTCsgK5eKXSdFvqPKVFkjGFCCzNLYPe6Eukql1c0yKsuhnMBxgtxe0VaNfJ/d91sNj+X97HnqcyBJTmXHVXpFDICXBo5LnoqLMaWcKYdlzu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185253; c=relaxed/simple;
	bh=L45ZHUW76JMrGXCpZTDkbXpqy+oHe8GXZEgOVfexB8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZlH8nEEeoNL8UHZA9MUVuGLONqmAp6XmTPOUa9EF0FbJavaRP6amkpRVzjtJ+5wBHjktoxaxYgUh+eN5lxBF4/zP8NHSfcSEVWoPRQ5OSE7aHKN3xvc3b2bx/5D5MPH/g6lFsv859HS9y2pb1jgLK97Xl/mQOJSaIqLO/um6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0cR9NE0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0cR9NE0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0411b83aafso108313766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758185250; x=1758790050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=M0cR9NE0W9Y1xN7+c4xlGTZwwhVigM/FIVmgKAIyZvwqF3Np4p7DxnWa2VF+gezaFy
         svZvKYCwUdmmAyap3TRZCZTt0eHvCqiX+5uMjpoX6Dp9KLOLcH/pD5INZwpurGQ9ZbXP
         vRobPnSAwwQ5I/V+z3lQ32nk0GeSoJHXbVB/WZrUX8WinuxqUdZdp4HcG2rvvVNfLnrb
         X+HxqJhjEPs9oHLaKCYMB6hgsPHKB3DMzSWKIM/MHV6GHofzL6XA/3RRzGQLMxlLtAw9
         aOS2FP2noNdiE/Zlk8JvO0Zb8Erbwee2waGIetr0UyAVy/whOhE8sSBQ/qe5zt/hJ6kp
         TgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185250; x=1758790050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dUuZLCrIMKFDhECHW6CRsaOlZAc9dyj1qs/1GGZce0=;
        b=DAoQ+qFh7NFRq3nGFNscmGVbfdKGlGRuJ7nomT6FO7cPx2eEmABm2VNq/4osFcwPpY
         /bAs2g0lb3yYCrKZR6pr438hnsQbomuQidZFm035AsajtdxUNpsNAHB3roCJuFXeWQsn
         Wj+mbe0qx7S9vNIorLbvnx/f5hA/xgXaMlK0qI0k4KlninoSMAtePYf3VjIbOk0j+VID
         6CfkEzVT9KXIU6DqymTPyQLX7HxbFUGhFxdSzYkhQ7gkiyxbx7P7ii2CUvDqcDy/v1uq
         RomDIH/a14Ovch7u1vd2jLyhQNuWqEN8qZhdwph/J1eg0w0AkRy3pg9QwtKkdtTN8wXn
         dO0w==
X-Forwarded-Encrypted: i=1; AJvYcCWVvFs1ZYbWhE1WcTpUhULA1Lx5t2sIlEN+ghYBXcXh9YjwzgMnXKoIfXED9In7Ivk5KOL/2lVax5tIYaB2q0UfCtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCqdD6E3cMPZz5z6VQDc8yJW+NmMuOy9G/QS/r7WpkO93k2Cz
	37jhgnFqiJ7rI9G18xSCO+buqx3OVhFfYU/ib0gDbaxfrNKcV0+wZWjv
X-Gm-Gg: ASbGncslljfmNBDRKenIWjg1i3ZcE/loSgOUK1nnVfWOQmkH36AP9X+I8oF0yldXCnh
	tHc/VLhWIY1G5gTejqpXhQT8CGNc5jB2xL6Y66dRt0oo1MUnOkhbg397YhrprRg8953RdE9h9e1
	ksE+tfEDCcQeXnd1VngKU4Sm3ez4d1ys/1CVViEOPMG0owa/6EDbcWNz9rofw8HILa4m4UaNwi9
	A8zI9K1MfiuAPlqW8aRK+K7otAniApJeg2Ptk13oGiXNBuYpYn+7e/9swyNT6iSXyscxsx+YdRu
	ZpcTzV5cmJw+n0UuwBo1SyTnKTn4ZowUCBlfpmC3hdKyOv3EaTQbPx5NBcIjcV1PVWahEl5SA5f
	koFzNS95cSmBalJArTSO2RzJCz7pM8Wtg/fPbt3m+ot1rbCiTA7ZGuQ==
X-Google-Smtp-Source: AGHT+IGSY6T0zgBstKzdppw+beER6+Ou6Xf+HZr5uZODjknR4sf0RTrkDM+Z+jzltMePgD/ZZBp0rA==
X-Received: by 2002:a17:907:3e8c:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b1bb6802513mr591131566b.40.1758185250193;
        Thu, 18 Sep 2025 01:47:30 -0700 (PDT)
Received: from krava (37-188-233-225.red.o2.cz. [37.188.233.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44bb1sm148036466b.21.2025.09.18.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:47:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 Sep 2025 10:47:15 +0200
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	haoluo@google.com, eddyz87@gmail.com, kpsingh@kernel.org,
	sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, shuah@kernel.org,
	willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
	martin.kelly@crowdstrike.com, ameryhung@gmail.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	yikai.lin@vivo.com
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
Message-ID: <aMvHE-iW5eAwf4km@krava>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
 <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>

On Thu, Sep 18, 2025 at 04:05:51PM +0800, Fuyu Zhao wrote:
> 
> 
> On 9/18/2025 4:02 AM, Song Liu wrote:
> > On Wed, Sep 17, 2025 at 12:23 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
> >>
> >> Hi everyone,
> >>
> >> This patchset introduces a new BPF program type that allows overriding
> >> a tracepoint probe function registered via register_trace_*.
> >>
> >> Motivation
> >> ----------
> >> Tracepoint probe functions registered via register_trace_* in the kernel
> >> cannot be dynamically modified, changing a probe function requires recompiling
> >> the kernel and rebooting. Nor can BPF programs change an existing
> >> probe function.
> >>
> >> Overiding tracepoint supports a way to apply patches into kernel quickly
> >> (such as applying security ones), through predefined static tracepoints,
> >> without waiting for upstream integration.
> > 
> > IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
> > tracepoint with btf (tp_btf).
> > 
> > Did I miss something?
> > 
> > Thanks,
> > Song
> 
> As I understand it, raw tracepoints (raw_tp) and raw tracepoint (raw_tp)
> are designed mainly for tracing the kernel. The goal of this work is to
> provide a way to override the tracepoint callback, so that kernel behavior
> can be adjusted dynamically.

hi,
what's the use case for this? also I'd think you can do that just by
unregister the callback you want to override and register new one?

thanks,
jirka
