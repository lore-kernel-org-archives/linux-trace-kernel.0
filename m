Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497C4C77A1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856533; cv=none; b=V0SmgIPWqjQUjTsWnJBzg0/26KqaSTHy0fqr/uQD0yB0pmG1v/xSr+blgIkw9qZLulpIl0Sga0HYob3jNfaikWkkJlgdGlfreWEBdaZTRJqaj9dkYXTUiaz47Glt9lKV3ZV3YayZLIU9IIo3sDch3ityVl+x1tKyo13v9NWJLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856533; c=relaxed/simple;
	bh=qqt81yiCVB6zcjzxn6h+LKvNrgx4abxq1QX5gE5xxAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vbezb2qje9zPFHENd8b76yzYzQIHocBtnovLD7KfCbU/sGScBNlUp2qKgF/INYAJzK8z4fQQ3/urwati/NA9uhLcAOB0JYZv+x7hH7+lviG9qduz86ok+f2B2ydtCFwUoRQ33vUU5uAFIbiyDYdEthoM5zBLRW2k3fKH5TGReao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTc4jTGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTc4jTGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E998D1F00A3A;
	Thu, 27 Aug 2026 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787856532;
	bh=8nwIGzaDh2MrGkPYy6uGA8wGmWFZKyLJK7Z8ZfQ9MtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTc4jTGy885pHbB096bZ9F88VCZXuyyGM+8DTmii/HFAxdaOA8TjUIdLdPYAfuHBW
	 DnDM4qHaoM3RpyPIlbkYiGZhJ8lq/D9tIYkPAbx8h1ezrdiCUYL12RrPDvGp9SxaWc
	 4l9pCwkQwfj35yC6uIAU405eAiDrzs2p7JNYWAYGOgfo1QsHun8uDoa42+R8ZRGCpm
	 hQ3rCRWgrJ2KfMW9+KZqNukS3wr6R5XBmVtkphqbIw/qZDBS77gqTOgICo53ac9PLr
	 im+N8cM/X0ISTM/8FZlhFo18nrjNs0I408i7+hQjd0+nnmkEj53S+ObI6AsjiQ+pqk
	 dBYGKKVLCvplg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <888aca9131b5e9c80ac5085f964099b5090e7185.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
 <888aca9131b5e9c80ac5085f964099b5090e7185.1787854397.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:48:51 +0000
Message-Id: <20260827184851.E998D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exporting `rv_register_reactor()` and `rv_unregister_reactor()` al=
lows dynamically loaded modules to register reactors. However, `rv_unregist=
er_reactor()` fails to detach the reactor from monitors currently using it,=
 and `struct rv_reactor` lacks an `owner` field to pin the module in memory=
. This leads to a dangling pointer and use-after-free when a reactor module=
 is unloaded.
--

commit f153a63763986ecb001f784d45c5262d45c8d0a5
Author: Wen Yang <wen.yang@linux.dev>
Subject: rv/reactors: export rv_register_reactor() and rv_unregister_reacto=
r()

This commit exports rv_register_reactor() and rv_unregister_reactor() so
that dynamically loaded modules and KUnit tests can register and unregister
reactors without link-time errors.

> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> index afc97d0971091..606c530de2f04 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -314,6 +314,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
>  	guard(mutex)(&rv_interface_lock);
>  	return __rv_register_reactor(reactor);
>  }
> +EXPORT_SYMBOL_GPL(rv_register_reactor);

[ ... ]

> @@ -327,6 +328,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
>  	list_del(&reactor->list);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(rv_unregister_reactor);

[Severity: High]
By exporting these functions, dynamic modules can now register and unregist=
er
reactors. However, when a module is unloaded and calls rv_unregister_reacto=
r(),
does this leave dangling pointers in monitors that are currently using it?

Looking at how monitors assign reactors, struct rv_reactor lacks an owner
field to pin the module in memory:

kernel/trace/rv/rv_reactors.c:monitor_swap_reactors_single() {
    ...
	mon->reactor =3D reactor;
	mon->react =3D reactor->react;
    ...
}

Since rv_unregister_reactor() only removes the reactor from the global list
without clearing active monitor references, won't rv_react() later execute a
dangling pointer when an event triggers?

kernel/trace/rv/rv_reactors.c:rv_react() {
    ...
	monitor->react(msg, args);
    ...
}

Could this result in a use-after-free pointing to unmapped module memory if
an authorized user unloads a reactor module that is still attached to an
active monitor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787854397.gi=
t.wen.yang@linux.dev?part=3D3
