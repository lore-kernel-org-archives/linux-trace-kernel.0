Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334608;
	b=gePCwoktlUhuGvFRWTangQKzYt7dp0KB5+mEURwzPZVRzmb0m0Sox5LoxfY3hn4gCRR/
	 Qtzv4DMhjywG6207YpdF7OW/1G+dGznX7u4XuXloWRfVwRx1Cj68ix3UCMHTe5qnR/dQf
	 NWTJoQFuZZr3R9ZHYEnnJUGiE5NqPFmzEo4zhhgH6hjTOSMt8Otu0UsZ160q/Ir4f/Fbf
	 0r5VYHEBQ8UGLpBJbg2QBZkf9xzYBpnS2m38HHJeExAf+LNIFixZ9Bk54o5AkFIDDP0B7
	 3JdWSLOAoxzsAMAqpHWnR9YoMkHcyfRWInMr4b13Gh0el1QHcz4J4ZH2GjIeu5qOE9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NYbkLYKQnxP5GXbMW1ibqGfC1S7pk30Ii0sqmJY8Dzs=;
	b=adtUc0XLLrGPbFOxZV+yjBnKOy8PhygZRQXCw/HM9irRedpkXHsNdv1VUK1r5cnB/yob
	 xdJf7qcfsrodxAs33giQh/ENsBR86R0pnA+OtWOHFnQDD8EPi2lTyOhpnuhm1a3f7UE1k
	 oO27C8pxeHw0YhmdyoCny+H1Qx+6QuXtGS7ojKwKLcQR8HCWpFqWZR5T6UyOPaBCJmUnu
	 ZHX7vAwq0Vip1hJmHh8XtCbG5q9ErGEABI8zbVOuAetMzBB+uespKUCIL7PdTCcbv2S8s
	 pCvwJ24cv/VGJ4sgjeNwZLHBeh8sNDPh5PZgiHdA+MUdzFu3Vc6CIGIiQRoOCyvMF1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcAB8zCX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F58606A331
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcAB8zCX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7584C1F0089F;
	Tue, 10 Nov 2026 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334607;
	bh=NYbkLYKQnxP5GXbMW1ibqGfC1S7pk30Ii0sqmJY8Dzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcAB8zCXakiwJ+I953TocDV23ZaPHCdfLKUQbjS5LWnqjs9snNeQ0WE6ssm+5dTuo
	 ewa8iwmhqq9yxlPx89TgaF7wFC2x0l4eSpfVQ/W4bTgHp0O0lUfv/baAa0CdGnJd30
	 xaDaRDtpMoPVqlztWKW26z5j3NdMz7BKdjIVZ8FFWZvwxpiSisrq0U5CydWM0GTeuX
	 MrqwFUY23UQuXAWmW9VjnAt4CHVkBHtp3Nrmg9RJRKHk+BrpKlFGADOB9FFrt4TTiT
	 59EbSCgBl5pMCy7tFyVswOrvqjBFw4yEd3FPZUFcBbniqnhNgZHlz9EdjBp1/cDwrk
	 Lwuj68qFhiXUA==
Message-ID: <sashiko-outbox-207566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] tools/bootconfig: Close only opened braces in
 compact output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduardo Mucelli Rezende Oliveira" <edumucelli@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <f2bad80ef771708417b75bf7f1286f9f2521ee97.1794333957.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com>
 <f2bad80ef771708417b75bf7f1286f9f2521ee97.1794333957.git.edumucelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 18:16:46 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tools/bootconfig: stack overflow in xbc_show_compact_tree()
  on deep subkeys
--

commit de9746e7a830d520494d15bd2077bf3c3e2cb8d2
Author: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>

tools/bootconfig: Close only opened braces in compact output

This commit tracks the nodes for which opening braces were printed in
xbc_show_compact_tree() so that closing braces are only emitted for
matching nodes during backtracking.

> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 56d76bdeaa098..1bab0e685e2d8 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -71,6 +71,7 @@ static int xbc_show_value(struct xbc_node *node, bool s=
emicolon)
>  static void xbc_show_compact_tree(void)
>  {
>  	struct xbc_node *node, *cnode =3D NULL, *vnode;
> +	struct xbc_node *parent[XBC_DEPTH_MAX];
>  	int depth =3D 0, i;
> =20
>  	node =3D xbc_root_node();
> @@ -100,7 +101,7 @@ static void xbc_show_compact_tree(void)
>  		}
>  		if (cnode && xbc_node_is_key(cnode)) {
>  			printf("%s {\n", xbc_node_get_data(node));
> -			depth++;
> +			parent[depth++] =3D node;

[Severity: Medium]
Can this write past the end of parent[] when a key with a value also has
subkeys nested deeper than XBC_DEPTH_MAX?

When a key has both a value and subkeys, the value node is stored as its
first child and the subkeys follow as next siblings of that value node.
However, xbc_verify_tree() only checks the first child for subkeys:

lib/bootconfig.c:xbc_verify_tree() {
    ...
		m =3D xbc_node_get_child(n);
		if (m && xbc_node_is_key(m)) {
			n =3D m;
			depth++;
			if (depth > XBC_DEPTH_MAX)
				return xbc_parse_error("Too many key words",
						xbc_node_get_data(n));
			continue;
		}
    ...
}

Because m is a value node rather than a key node, xbc_verify_tree() does
not descend into the subkeys under n and never enforces XBC_DEPTH_MAX on
that subtree.  When xbc_show_compact_tree() later walks those subkeys via
cnode =3D xbc_node_get_next(cnode), depth can exceed XBC_DEPTH_MAX and
overflow parent[] on the stack.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794333957.gi=
t.edumucelli@gmail.com?part=3D1
