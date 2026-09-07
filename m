Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A881B67E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753867; cv=none; b=ZHI9tb8Vv4+4qaIzOGmWca+jsEv4bJviEDB2MVbeqNVvUQdXx6cmBtAxQSSkKuHWpeWSYagU2VOVokQpz8rAVfTWAKVu35b5DqT34YoWKSK8IXV1jk8+PnoxepN7BgUxZ2XLGHFyNE1ujNgcHOI7k7LX6zMUy0dPeR4UtjKTdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753867; c=relaxed/simple;
	bh=+nbIk0svLnXsMVPyJSCyuNyPOXaBYwpGrnil3tYK5Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9yXIxCn/xZRHXXZkf9Dz9v7rA74HCOQOuJmsfCETp6uLUPbYWqBRO0hE/Iqy6losvBrSoObafH5DBrsvgdEL0xNhmoADANtK1tgGsYIoliOvalIcdZ2ftyOthYwzIdvNjjnYiNGY1EOzoxDfML4KjyMpCk9DmjMfCLB5e2nSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwLGJ13m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwLGJ13m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BE51F00A3A;
	Mon,  7 Sep 2026 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753865;
	bh=s5kN3fv031/ncpBeZ9diTyoY6/Zxu+0f06YSQkLX7oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwLGJ13mPXXNVm42D2Yf8c5JQy8s2X5V7k+ZO70t3+DuzmFRD5mCAtajFJfyVe1yf
	 TqyMiCGg3Kl1f/9ewijCRJXcRIhRxzqteLy3N0iXBDERKdHeezswbm+nMnJwgRdAr2
	 hwkRKx4fRsz8uaocBCuW/jYS/Jw9hZr6gkcnWSmIRIWyrGfyQTgwdqeHC4m63D9/a+
	 qiAvlITghiaugzZzbwhnpGCmZCOhxR/FcWGOh1TTrcag08mAtpDaezPJeJ3qphm8Ko
	 +oR3qRx2+hZGGfZ0W6SqngHZ/tH62WAW0AwU4IjrYRVMOQm+j+qe9yi63fJM0F6cyn
	 LyJeRQ4fOqdMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: hist: free the field rejected for a bad
 modifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907034948.240387-1-donggeunyoo.kernel@gmail.com>
References: <20260907034948.240387-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:04:25 +0000
Message-Id: <20260907040425.92BE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting memory leak of VAR_REF hist_field objects when a varia=
ble is referenced 3 or more times.
- [High] Preexisting memory leak of VAR_REF hist_field in create_var_ref er=
ror path.
--

commit 899dd39af79bb308de7335dd48b6656e713c7a62
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: free the field rejected for a bad modifier

Writing a hist trigger whose value or variable carries a modifier that is
not allowed there leaks the fields that were built for it. This patch fixes
the leak by using destroy_hist_field() to free the rejected fields when
a bad modifier is encountered.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 893bd8b0e48a8..6b5572ef2d4ba 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4331,6 +4331,7 @@ static int __create_val_field(struct hist_trigger_d=
ata *hist_data,
>  	return ret;
>   err:
>  	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
> +	destroy_hist_field(hist_field, 0);
>  	return -EINVAL;
>  }

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under rev=
iew,
but since the commit message mentions that destroy_hist_field() returns
early for HIST_FIELD_FL_VAR_REF, does this behavior cause a memory leak in
the error path of create_var_ref()?

Looking at create_var_ref() in kernel/trace/trace_events_hist.c, if
init_var_ref() fails:

		if (init_var_ref(ref_field, var_field, system, event_name)) {
			destroy_hist_field(ref_field, 0);
			return NULL;
		}

destroy_hist_field() explicitly skips freeing fields with the
HIST_FIELD_FL_VAR_REF flag:

	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
		return; /* var refs will be destroyed separately */

Since the ref_field failed initialization and hasn't been added to the
global hist_data->var_refs array yet, will this object be permanently
leaked rather than freed during global trigger teardown?

[Severity: High]
This is also a pre-existing issue, and was not introduced by the patch under
review, but is there a permanent memory leak of VAR_REF hist_field objects
when a variable is referenced 3 or more times?

For example, when a trigger is created referencing the same variable
multiple times, or fails during parsing after reaching 3 references:
hist:keys=3Dpid:val1=3D$x:val2=3D$x:val3=3D$x

destroy_hist_fields() calls __destroy_hist_field() exactly once per unique
variable in hist_data->var_refs:

		__destroy_hist_field(hist_data->var_refs[i]);
		hist_data->var_refs[i] =3D NULL;

However, in __destroy_hist_field(), there is a refcount check:

	if (--hist_field->ref > 1)
		return;

If a variable is used 3 or more times, its initial refcount would be at
least 3. When __destroy_hist_field() decrements it by one, the refcount
remains 2 or higher, causing an early return without freeing the memory.

Since destroy_hist_fields() sets the pointer to NULL immediately after,
could this permanently leak the VAR_REF object because no other code drops
references for these objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907034948.2403=
87-1-donggeunyoo.kernel@gmail.com?part=3D1
