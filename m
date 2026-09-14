Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EEB39E162
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413952; cv=none; b=O78tN14559Yo0Bx44QLzez71vsBhY2OhszB0GEPB0oAb7eONKG0zBgBS4hrq60dITK1d0PPloIQC5suoxtOTw5Oul/+Fn8Ea2FyqtM9UepbJ3mv5Ur6oNkDuUxDUnSogg6P8y8oj+b8uZBaNKRFhHwjG2eozrk9+mkkq6h6hRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413952; c=relaxed/simple;
	bh=BYILY7iCsohqdQ05iwTiR15TBd05/BpAHCQFtnyIHh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLgLwxu/lOnw1pEUYADGk3W1hPf7dPp6NMgiyIaPdQJgdoT8F/8+d+DWXTbxfR7wJZ8ck418mMHxCPae+51A/UPsX9r7s8M4fk4mEws1WCRnKAjRGFWvXk0h72frPIzT1S8jds3gb+iRtweboPMd6mQEfZPfHxc4qUBgGFgiUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvBBfotp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvBBfotp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1148A1F000FF;
	Mon, 14 Sep 2026 19:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789413951;
	bh=PAg9ybcxu/oU4K+vFVfpIYNgqIzUH/er3zGpgCg5n5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvBBfotpX9faTaKSxAK9U8bVw3gzqNl2xhMggHYBLR810qlj+iuYcpll/FFfX97Zy
	 e2oINAwVh4UhJoK+r8dEuN8B18KJASpBYk7Amr/wqV7GapD0shISYTVzsBwLFITR0t
	 oM4JoetBxSVacY1Dtpijt22eTW8zcsmlELd5yVEe4/Kb7DESpzBAo59s9n99bQAWNk
	 15NPwbF96wTYe7nQUDyNnG/Oq/YjT/Grkb94kM7WXuyAB8zqcVxO2l/ERgcgCvpPtP
	 OVBQGXMhtSkHAapBAlJaljF/wCVo2nO1H00S7CS6q/8Vrfa00MqZZ6zscxUxqgPocM
	 Zyq6seNC/wLgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <94b7ec120a92b9368541ac050601e66be8fe653a.1789412799.git.wen.yang@linux.dev>
References: <cover.1789412799.git.wen.yang@linux.dev>
 <94b7ec120a92b9368541ac050601e66be8fe653a.1789412799.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 19:25:50 +0000
Message-Id: <20260914192551.1148A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exporting `rv_register_reactor` and `rv_unregister_reactor` allows=
 loadable modules to register reactors, but failing to detach the reactor f=
rom active monitors creates a critical execute-after-free vulnerability whe=
n the module is unloaded.
--

commit 516262534066676c40b564e9e3018cd406dd5532
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: export rv_register_reactor() and rv_unregister_reactor()

This commit exports rv_register_reactor() and rv_unregister_reactor()
with EXPORT_SYMBOL_GPL() so that reactor modules and the tristate KUnit
test module can register and unregister reactors.

> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> index ff7d478227c32..8e57a95d446b5 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -314,6 +314,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
>  	guard(mutex)(&rv_interface_lock);
>  	return __rv_register_reactor(reactor);
>  }
> +EXPORT_SYMBOL_GPL(rv_register_reactor);

[Severity: High]
Does exporting this API without module pinning allow an execute-after-free
if a module is unloaded?

Although the commit message notes that actual pinning is left to a follow-up
series, exporting the API in this patch makes it immediately usable and
inherently unsafe for any module. This includes the in-tree KUnit module,
which can race with a sysfs write during its test execution.

> =20
>  /**
>   * rv_unregister_reactor - unregister a rv reactor.
> @@ -327,6 +328,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
>  	list_del(&reactor->list);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(rv_unregister_reactor);

[Severity: High]
Can unregistering a reactor from a loadable module leave a dangling pointer
in an active monitor?

If a loadable module registers a reactor, and userspace assigns it to an
active monitor via /sys/kernel/tracing/rv/monitors/*/reactors, unloading
the module calls rv_unregister_reactor().

This function removes the reactor from the global list but fails to detach
it from the active monitor. When the monitor subsequently triggers, it will
dereference the freed memory in rv_react():

kernel/trace/rv/rv_reactors.c:rv_react() {
    ...
    monitor->react(msg, args);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789412799.gi=
t.wen.yang@linux.dev?part=3D3
