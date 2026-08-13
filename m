Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E012EBBB9;
	Thu, 13 Aug 2026 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661496; cv=none; b=OYnF28p074+A6O8diczMq/n54u5l1RbBzP/HQdthemIYQsEMY3EMmnbX2wOYI6sqeEQ7rfF57S0EfhUQ7IrzYn0iuf8KMCyBSrphBj+fOiBOPsmMwKQPYVbv0b/uCEUUrw0vwKeUjRPud9Zhgmqh1RqC1Y8EI5IzLU5o1npFGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661496; c=relaxed/simple;
	bh=CMBCQjjuL9iHDRdGF1/bzRuWSoVNhKKBAnbkYC2bJqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=If/9FHANET4cN3bXhRcci+V1Y+P2mZcndcbllMz/jEYncAcivG+PEucOZWx4UbaaMyUa7gTiGCSNVglaXl3gtRJUmzG6FXZJTox3mjGE1VI84LicRlS1D7nNgzaHFrTbQGIGwyipw+Xjos4+zj8PQh9UM6rQ8k8v3o+lD91IyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAuUZH87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAuUZH87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF471F000E9;
	Thu, 13 Aug 2026 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786661495;
	bh=U2ytmh6H0BwdypntoKyZImTiAoYrsm6+Io/A1/Krb9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAuUZH87CVPkrqaZ8TqrjUAQ3oeiW72COow/LB7vtGOYg9e10ukDMeiFwj3aqdtaL
	 vME3hAVFlQGbW3Djn4R+FE5DEvkpOEddLIx9JsUKpZ6qIAH4zwRWu+jfSkYmHRuvkd
	 qdrlkZqQj8EjYKek5fmeOuYrbDO6VT2vjm5+2VU92u68nQBZkMD910OfdaWwUOqOHC
	 B+T8RjnCfVSqjKWfzOcXyvQtnx1ZMjZR+rLppyKEN2rn4zSpjrFkUUpzgLpgdCRmSA
	 W1oLlGDwIx+FnXxwvtMetKQv/I91AaIIYhUotaTX9P/ryvLoTyxQAO2yoEh7/jy/4i
	 5uJmwtAzpcYkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 13/44] KVM: guest_memfd: Apply content modes
 while setting memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260326-gmem-inplace-conversion-v4-13-e202fe950ffd@google.com>
References: <20260326-gmem-inplace-conversion-v4-13-e202fe950ffd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:51:34 +0000
Message-Id: <20260813225134.DFF471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] WARN_ON() discards the error code from kvm_gmem_apply_content_mode=
(), leading to silent failures and a user-triggerable kernel warning (DoS v=
ector).
- [Medium] Applying content mode without invalidating MMU mappings when mem=
ory attributes do not change causes data races and potential hardware machi=
ne checks.
--

--- Patch [13]: [PATCH RFC v4 13/44] KVM: guest_memfd: Apply content modes =
while setting memory attributes ---
commit 47c20f7dd20767b04a5efc7e5951d56b44e5a590
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Apply content modes while setting memory attributes

Provide defined memory content modes so that KVM can make guarantees about
memory content after setting memory attributes, according to userspace
requests.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e270e54e030f0..eeac7678fcf4e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -752,9 +783,23 @@ static int __kvm_gmem_set_attributes(struct inode *i=
node, pgoff_t start,
> =20
>  	filemap_invalidate_lock(mapping);
> =20
> +	if (!kvm_gmem_content_mode_is_supported(kvm, content_mode,
> +						to_private)) {
> +		r =3D -EOPNOTSUPP;
> +		*err_index =3D start;
> +		goto out;
> +	}
> +
>  	mas_init(&mas, mt, start);
> =20
>  	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs)) {
> +		/*
> +		 * Even if no update is required to attributes, the
> +		 * requested content mode is applied.
> +		 */
> +		WARN_ON(kvm_gmem_apply_content_mode(kvm, content_mode,
> +						    inode, start, end));
> +
>  		r =3D 0;
>  		goto out;
>  	}

[Severity: Medium]
Does this path allow the host to modify memory (e.g., zeroing it) while the
guest still has active PTEs?

Since this early exit path skips kvm_gmem_invalidate_begin() or
unmap_mapping_pages(), the KVM MMU is not zapped. Could this introduce guest
data races, or hardware state machine violations if the architecture-specif=
ic
preserve operation acts on actively mapped private pages?

[Severity: High]
Is the error code from kvm_gmem_apply_content_mode() being discarded here?

WARN_ON() evaluates to a boolean and its return value isn't captured. If a
folio is hardware-poisoned and kvm_gmem_apply_content_mode_zero() returns
-EHWPOISON, it appears this will silently return 0 (success) to userspace=20
meaning memory was not zeroed as requested.

Additionally, since this is reachable by untrusted userspace via the=20
KVM_SET_MEMORY_ATTRIBUTES2 ioctl, could this trigger a host denial of
service if panic_on_warn is enabled?

[ ... ]

> @@ -786,6 +831,9 @@ static int __kvm_gmem_set_attributes(struct inode *in=
ode, pgoff_t start,
>  	if (!to_private)
>  		kvm_gmem_invalidate(inode, start, end);
> =20
> +	WARN_ON(kvm_gmem_apply_content_mode(kvm, content_mode, inode,
> +					    start, end));
> +
>  	mas_store_prealloc(&mas, xa_mk_value(attrs));
> =20
>  	kvm_gmem_invalidate_end(inode, start, end);

[Severity: High]
Similar to the early exit path above, does this discard the error code from
kvm_gmem_apply_content_mode()?

If this is modified to capture and return the error code, would we also
need to call mas_destroy(&mas) on the error path to avoid leaking the
preallocated maple tree nodes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260326-gmem-inpla=
ce-conversion-v4-0-e202fe950ffd@google.com?part=3D13
