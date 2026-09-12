Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77C34887E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177586; cv=none; b=n+caJSc3Q8af/WusKn9THaqYOCGOA5RBWyHnvXUXkAMaSeZ3DvUpLX4G5Y097Gx4heL1yBONBd3zhgH5Y/htKpTE4TlJ4+guLTv00LMHc/StTQf9eQeV42daq66yFfvmPjzUQWdh3DLvSeSs3YW7roiTEiVPmN/jeaqsdro8hjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177586; c=relaxed/simple;
	bh=/6LlnANIZe3SO0uKJmHvAh0i773OZbL7WI4g97EAoGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKlEDKZwbKdUrsdaCX/FolgalaCMNQpIj40VVwrvXbh8Q4/GcIOPcvPSUS6OAI0KwOuXwZysTWpuNZKfqXaog31wg+MKMlw4KZuN9YK4OhU6a6Pv0dNCnE1tivDE0lO4Gf9zenhB/YE/Z/Iia3rFRZ09HkJMnUwQlfqLYioRUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3GZpjXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3GZpjXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391661F000FF;
	Sat, 12 Sep 2026 01:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177583;
	bh=XPWAtIXeLErjBOW7mxgort3FEXSPhfgZ88Fa8nJ5KlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3GZpjXYYoJHLFwmIKd2KhgDXvSxg3unbVV+EEJ9Y6HVjl3gQt1t3dmijb8Pruhpg
	 JxV0tztu6sKOR6GAjeklH449fWKnIodQT8dr51s8cMdyTE6qxXaoNR7+8hGiseF4Xt
	 57NwvezQ61PluHeljfGYvDiestWakOoTb0APOBG4F1o0bviB8B8LXIW1UN3ZeZOHEo
	 7q7wuUwW+0d9OaoGhTDMmX4pfvcRse0emJJMdtCG4uNObD+YDg4H2G1SL//Go6JFSl
	 4v72VJtaiHXgF+CkFIXpNN+ucK3pOxFgoy+VcGlOEjaGNeZhWHRTu3Wgv76Db5nHG+
	 QOhQQV88VDdaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] sched: Extend task command name with
 TASK_COMM_EXT_LEN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911-tonyk-long_name-v7-4-34e1ee1564ae@igalia.com>
References: <20260911-tonyk-long_name-v7-0-34e1ee1564ae@igalia.com>
 <20260911-tonyk-long_name-v7-4-34e1ee1564ae@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 01:46:22 +0000
Message-Id: <20260912014623.391661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Increasing `tsk->comm` to 64 bytes breaks the implicit null-termin=
ation API contracts for both `__set_task_comm` and `copy_task_comm`, leadin=
g to kernel out-of-bounds reads and trace data corruption.
--

commit 5f2c83bf644707c42f3dee91b932f9dde7986c03
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

sched: Extend task command name with TASK_COMM_EXT_LEN
   =20
This commit extends the task command name from 16 bytes to 64 bytes by
adding TASK_COMM_EXT_LEN. It caps existing userspace APIs to
TASK_COMM_LEN to avoid buffer overflows while leaving the full extended
name for a new interface.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ba20405664246..c4e0104e7ae9b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
[ ... ]
> @@ -1187,7 +1188,7 @@ struct task_struct {
>  	 * - set it with set_task_comm() to ensure it is always
>  	 *   NUL-terminated and zero-padded
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				comm[TASK_COMM_EXT_LEN];

[Severity: High]
Does this change cause an out-of-bounds read in __set_task_comm()?

__set_task_comm() in fs/exec.c relies on sizeof(tsk->comm) to limit the read
length:

    size_t len =3D strnlen(buf, sizeof(tsk->comm) - 1);

With tsk->comm now being 64 bytes, strnlen() will try to read up to 63 bytes
from buf. However, the set_task_comm() macro still explicitly permits
passing 16-byte arrays:

    #define set_task_comm(tsk, from) ({ \
        BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN); \
        __set_task_comm(tsk, from, false); \
    })

If a caller passes a 16-byte array without a null terminator, __set_task_co=
mm()
will now read up to 48 bytes past the end of the array.

[ ... ]
> @@ -2042,7 +2043,7 @@ extern void __set_task_comm(struct task_struct *tsk=
, const char *from, bool exec
>  static __always_inline void copy_task_comm(char *dst, struct task_struct=
 *tsk, size_t len)
>  {
>  	const char *_src =3D tsk->comm;
> -	size_t _len =3D min(len, TASK_COMM_LEN);
> +	size_t _len =3D min(len, TASK_COMM_EXT_LEN);
> =20
>  	if (!_len)
>  		return;

[Severity: High]
Can this cause trace data corruption by omitting the null terminator?

When copy_task_comm() is called from a tracepoint with len=3D16 and a task =
name
longer than 15 characters, it will now copy 16 non-null characters into dst
without adding a null terminator.

Previously, tsk->comm was guaranteed to have a null terminator within the
first 16 bytes. Now that the name can be longer, the first 16 bytes might
all be non-null characters.

When the trace ring buffer is later formatted using %s, vsnprintf() will re=
ad
past the 16-byte array into adjacent ring buffer fields, causing an
out-of-bounds read and leaking or corrupting trace data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-tonyk-long=
_name-v7-0-34e1ee1564ae@igalia.com?part=3D4
