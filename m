Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF41E2848
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876317; cv=none; b=QE+i4pHXTxtglVVSzj6tRKwJA+4Fev9TORDMCU6y0B+c8cdJiceKbbPx9BRb9ysWgZ6MMRkanuSe7a282ab1Z0AyF3p289L4mG9EJBj2TpsGsmnmMBnTKRGkb/NK0hN7HOhCVp0eiFfrHVIF/iLlc2TR5cL9hGpw2Hh1xYj+iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876317; c=relaxed/simple;
	bh=jgREDXGePmQdfd2E7Vl8U2KGORUW/8wrdY5g6v1eY0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPEdUYb4TJXenmzkGQxtEIcDnNjsgAlsWo8La/G+IgL+hUEMsDiZOdiA2JkxkamdS6oeCNMvqe+0flQE1HIizEenqTSqi5P9HpmmzeUkCN7PLa3Eta/KNKEz7DQ4oN/0h74UF8hwaTonn2abTwr7i6eeprxbZr5ypxitGKnj4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k2DX2/ke; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2DX2/ke"
Message-ID: <7754e178-d8dd-4f11-a300-1fc964a5916f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753876302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cofzKk3+SnpP5m/YhFynok1TZi2YE/wS6Sd7AtPq+HE=;
	b=k2DX2/keevHls4RWwiShG9QTYYdPCBaBEnDitRcDbUIdV/Sf9k7fpwDfenlMoA4N4j3bWV
	XjmnquGeZ5v3b+SPyOGcao0dSkA0F0ywg9ppoeBG4ENvYAKATfOaAncZkeSywfUN1YBRGH
	BSgbX1yVSgL14a8i7ub+xecn0/53i8M=
Date: Wed, 30 Jul 2025 19:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] tools/latency-collector: Check pkg-config
 install
To: rostedt@goodmis.org, bristot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250730113028.1666038-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20250730113028.1666038-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/30 19:30, Tao Chen 写道:

The branch tag is wrong, i have resent it, sorry for the noise.

> The tool pkg-config used to check libtraceevent and libtracefs, if not
> installed, it will report the libs not found, even though they have
> already been installed.
> 
> Before:
> libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
> libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> 
> After:
> Makefile.config:10: *** Error: pkg-config needed by libtraceevent/libtracefs is missing
> on this system, please install it.
> 
> Fixes: 9d56c88e5225 ("tools/tracing: Use tools/build makefiles on latency-collector")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   tools/tracing/latency/Makefile.config | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
> index 0fe6b50f029b..6efa13e3ca93 100644
> --- a/tools/tracing/latency/Makefile.config
> +++ b/tools/tracing/latency/Makefile.config
> @@ -1,7 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
> +include $(srctree)/tools/scripts/utilities.mak
> +
>   STOP_ERROR :=
>   
> +ifndef ($(NO_LIBTRACEEVENT),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
> +  endif
> +endif
> +
>   define lib_setup
>     $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
>     $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
-- 
Best Regards
Tao Chen
