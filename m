Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B5279354;
	Tue,  1 Jul 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383289; cv=none; b=GU+jhtm0kc7QJ07EiYbwd/peLR8ZbFRBXkZCD9nRBrtpdG3gEaEvkuyR8sXC02R9xbGXscYQHLOG1aSazdf+ulMsWmBZbfAzLt9fPH2QxRfrbK3SRU3B1mN55XU6V2vYhQCrLlMk46WauAMiPhszTfVJa03iNv+hmf4IdF3nMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383289; c=relaxed/simple;
	bh=gEJZSp/jqAQmTBET9Lgo0F4Y5CN9so5vYjZ9igwKwG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeQpg5fJKSuVIU0ETXSN8itWEkNXKSAXlsK2ki6FgG4yzVrjUdqkjs9EbKOdyXohUX9fUBrhG4cQXhwDXmVMBAC8k/q+weo0FsOZ26RqfK6BMq/GemxCitNE4I0XbNbvixByRor5BIP8RE7FIzXeJkJA4wBo/wC8zeROxcqk+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E517DB9E49;
	Tue,  1 Jul 2025 15:21:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 62A7A2000E;
	Tue,  1 Jul 2025 15:21:17 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:21:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Yao Zi <ziyao@disroot.org>, Andy Chiu <andybnac@gmail.com>,
 alexghiti@rivosinc.com, palmer@dabbelt.com, Andy Chiu
 <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>,
 puranjay12@gmail.com, paul.walmsley@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, eric.lin@sifive.com,
 vicent.chen@sifive.com, zong.li@sifive.com, yongxuan.wang@sifive.com,
 samuel.holland@sifive.com, olivia.chu@sifive.com, c2232430@gmail.com, Han
 Gao <rabenda.cn@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 regressions@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION] Random oops on SG2042 with Linux 6.16-rc and
 dynamic ftrace
Message-ID: <20250701112116.24cf8163@batman.local.home>
In-Reply-To: <b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr>
References: <aGODMpq7TGINddzM@pie.lan>
	<b060e694-caa0-4aa5-ac67-75531a5f60eb@ghiti.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 62A7A2000E
X-Stat-Signature: 59cfkw1pdim9kresnutii68uakri7p8t
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/NJMVWipJuBxIYkuT6e6RUoPIwwQiqAis=
X-HE-Tag: 1751383277-669370
X-HE-Meta: U2FsdGVkX182ALet42c3iMi2YFUYr6K+qXWSp9Nc2/oYd4UWY+lrz0yseqtNdf6s4czTyAhl5x/WZDEy3JbSXCbHDUBzGKoGw881QaXZ0ZsNE5KwJ/VDEiMwGYgEDlxQRRgmsoe+oGOwdoiHeZGVY8opsV8mRqdJhWy1IQGC73NeW1eMVY3rIrmb+6G0erF4jL93o1W4Wx3KJs1PLKxzpg7wAW1ad9oPC98SY87CUhOkRZE1ZzVdjmLD+HsHgydL+CSpVZ93Y8SBw2qi066qFiGHlmYeeyU+chGglyPEoNGNo5zNX5cGPjR0HknSPNxd

On Tue, 1 Jul 2025 14:27:32 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> @@ -149,16 +157,17 @@ int ftrace_init_nop(struct module *mod, struct=20
> dyn_ftrace *rec)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nops[2], offset;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&text_mutex);

This looks like a prime candidate for:

	guard(mutex)(&text_mutex);

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ftrace_rec_set_nop_op=
s(rec);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto end;

Then this change wouldn't be needed.

>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D (unsigned long) &f=
trace_caller - pc;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nops[0] =3D to_auipc_t0(offse=
t);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nops[1] =3D RISCV_INSN_NOP4;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&text_mutex);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D patch_insn_write((voi=
d *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> +end:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&text_mutex);

and "end:" as well as the mutex_unlock() can be removed.

>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>=20
>=20
> Andy is also taking a look, I'll let him confirm the above fix is correct.
>=20
> Thanks for the thorough report!

Yes, thank you Yao Zi for the very detailed bug report! That made
things so much easier.

-- Steve
