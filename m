Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844896;
	b=pHE/nyac+1chqzvzNdLwiS3qjah40J7svmaBK3gGHwk3xPGZ3qbCwR78oIYwazydqv+C
	 7dfi2v5KOYLqYfvIDTfqAfnoQtS1AZ+xJvEpcyIrqUu4utRZDvRhW2vB4fYnnJlwREn3b
	 cevf6i/l4hsXCBGvaSUHYSW0DuxH9NS8IpfjgcoCTzrWafGahrBAuv4VWVDeQgyClrp3m
	 4zDfvYxSksTETWyPw2rLJKhTeXzeFPp0xp4v1WEACws/PWlm3r1loNXA/wdlSaI8qtB5/
	 enG0IGNEPClMaB/me63ok1RPVBdEtwq2iYXBVf9CIvIRS+2Nc5X9iPabxunn478NAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8AtIllrW3jqSU2MyKn8xX9LlKY0ZVFVj8MIH4CkTtAY=;
	b=uCRJ/fs5vjj/VvbZXcA5awHJvUnCXFJ1LGq1P6rGfY4AiL4Z2EmvFIsj51QYEBHQDHlp
	 9rEplJnLbxSbomqfLrP8JbjLMzwDw9JR2nWrj6iLwYqmZ044y38gcqFEzwBI94gYmXGY2
	 KYxeZgpD/lXK4fOfnPP0LMHYDcL2+ieywPNu5v+aJQa9c9EfvAmNEq2jXmwHvsHvtHMUE
	 sbCm0U/QIDZRPwfllxjjSw3qZ+HCwaWw9WdM25hGZ6jpF2bNmt+lzPEv8C7ZGWMBfVkLf
	 c+LWfmXaTgaps/qB7G5Di7W68nQfU9v4jMVS24CLTrU+n3j2G1MJqGpGXCXuynwBuUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia96QjDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD03606A322
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ia96QjDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6181E1F000C9;
	Mon, 16 Nov 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844895;
	bh=8AtIllrW3jqSU2MyKn8xX9LlKY0ZVFVj8MIH4CkTtAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ia96QjDyEKndifIqCXgqfvMzf6Zox2bMdAlqM/Dj1njB/JjATdeOf/BN06nHV9Rtw
	 TWaSLP+EQGdKfHocjUmcSN1U8ORgBNrIZDSzt3/pN37jQiIkJBWwmi2sbSxg4bJTMI
	 ngmrbYHzcXUQXh8Vsk55VHdh7bOLekYk0E4e8eJOMnlNj7/PmLMiG76w5xBsmTGv9x
	 YaQ5kdQDN26rbSRKRsJLVfPbglPLSJ5Snni7jaoQt6Yho47qcKY6GUwq7fvg9hnNWv
	 b/3f2k8o36dyBISxWDYJeB5jQ8EgiH6UNULJ+KYhSPtuWOxFev0YXgroivIrXoSAx1
	 Ig6oXwQOzrliQ==
Message-ID: <sashiko-outbox-217334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Fraile Alonso" <pablo@pablofraile.net>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
References: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:01:34 +0000
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
- [Medium] uprobes/x86: REX2 map-1 opcodes bypass good_2byte_insns in
  uprobe_init_insn()
--

commit 4da9c45b309734e7a1e4eb07255d608c16d67ca3
Author: Pablo Fraile Alonso <pablo@pablofraile.net>

uprobes/x86: Fix bypass of two-byte opcode validation

This commit updates uprobe_init_insn() to switch on insn->opcode.nbytes so
that two-byte instructions starting with 0x0f are checked against
good_2byte_insns instead of matching bit 0x0f in good_insns.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 0f60c0d076b62..1cf901d186884 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -292,14 +292,24 @@ static int uprobe_init_insn(struct arch_uprobe *aup=
robe, struct insn *insn)
>  	else
>  		good_insns =3D good_insns_32;
> =20
> -	if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
> -		return 0;
> -
> -	if (insn->opcode.nbytes =3D=3D 2) {
> +	switch (insn->opcode.nbytes) {
> +	case 1:
> +		if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
> +			return 0;
> +		break;
> +	case 2:
>  		if (test_bit(OPCODE2(insn), (unsigned long *)good_2byte_insns))
>  			return 0;
> +		break;

[Severity: Medium]
Does switching solely on insn->opcode.nbytes still allow REX2-prefixed
map-1 (0x0f) instructions to bypass good_2byte_insns?

For a REX2 prefix with M0=3D1, insn_get_opcode() stores the map-1 opcode
byte in insn->opcode.bytes[0] (OPCODE1(insn)) and leaves
insn->opcode.nbytes =3D=3D 1:

arch/x86/lib/insn.c:insn_get_opcode() {
    ...
	if (insn_is_rex2(insn)) {
		if (insn_rex2_m_bit(insn)) {
			/* map 1 is escape 0x0f */
			insn_attr_t esc_attr =3D inat_get_opcode_attribute(0x0f);

			pfx_id =3D insn_last_prefix_id(insn);
			insn->attr =3D inat_get_escape_attribute(op, pfx_id, esc_attr);
		} else {
			insn->attr =3D inat_get_opcode_attribute(op);
		}
		goto end;
	}
    ...
}

In uprobe_init_insn(), those instructions enter case 1 and test their
map-1 opcode against good_insns_64 (map 0) instead of good_2byte_insns,
allowing disallowed 2-byte instructions such as syscall (0xd5 0x80 0x05)
to pass validation while rejecting valid map-1 instructions such as
bswap (0x0f 0xc8..0xcf) whose opcode byte is 0 in good_insns_64.

In addition, because bit 0x0f remains set in good_insns_64, a 10-byte
REX2 M0=3D1 instruction has its insn->opcode.value shifted and ORed with
0x0f in-place by can_optimize() -> is_optimizable_nop10() ->
insn_is_nop() without updating insn->opcode.nbytes, so case 1 tests bit
0x0f and accepts any 10-byte REX2 M0=3D1 instruction regardless of opcode
(as well as an invalid REX2 M0=3D0 instruction with opcode byte 0x0f).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-x86-uprobe=
s-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net?part=3D1
