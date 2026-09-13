Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C886315D49
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332315; cv=none; b=uBbQfqmAcACctmZx6c8VTxIdki2qQC2YcinWAjmRF6FxBNNGVgGBQlK+FeNeGSWuE6CkQPcsmVRIt32s8orubijz5YNATaCKX2zl+1Sj45mAM1fN7B1zjcg8bfdYnVbtLxkfZf8DsuBBXQY0RKQH12q42Pp3lxWQw036EBvz9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332315; c=relaxed/simple;
	bh=xQMJ1zteChOF/ynzo/0uX1S+0UG7BACdLMLYWuqr+7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ck5s/Vj4UFDEW/XjEjMHXNIadaRTfbdozd6ouqALT7Gg4wvVOgQzRqO5gEUEeJNHMmzn45q7qxdSbd7AWjyD5kvoIQtl+Ft7++9Mk9k9AvwvyCfragtxpDJZ4tF53odDm8ujPyrgWRCJt5K2Gbe0IQ2tmENwniTKSetxoQo3Bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2el+Wv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2el+Wv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACA31F000FF;
	Sun, 13 Sep 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332314;
	bh=Mvi6edeO7wqa37W4F/Sq9jxgkxpvFPnVX5BzYt0eC1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2el+Wv3oF/hS9EGH4UVnpMxVyIYI0okGuNKWXuBi9u+yVdMjqxnLpx39AaTE7sJm
	 A+D7SED10gDwr/5+XgSC2lm39h9TGK2BH49bwrM4LmlIxQHgVOGqYVTgg9TcZfvbdr
	 E5QuAxcLUR1k2oM4w0J91NngNOOdyFU9uLFn3dK0lPFTfrIfgEHlfRwonaJCi8rROs
	 RjwwKFE/EkSIJ1HlneuOX98fske31Z3UoXAt59GWAGgHVFp1lqGkXdW3lnAG729ErN
	 9xMENmKYQczq14JtXeeiVNuMEQ9X09rv3unyTduTxa0Le5mjKjfX07RdHrVET5/Eq0
	 umKb+bkfa5nwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Add the bucket size to expr_field_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260913203129.941270-2-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
 <20260913203129.941270-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 20:45:13 +0000
Message-Id: <20260913204513.DACA31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect format specifier `%ld` for `unsigned long` field `buckets=
`.
--

commit d2b0e0ac39deb1a14a5fe6656a43dc160480944d
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: Add the bucket size to expr_field_str()

This commit updates expr_field_str() to append the bucket size count to the
rendered string. This matches the behavior of hist_field_print() and allows
legal histogram keys with .buckets to be handled correctly.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..9d7ce01fda360 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1755,6 +1755,9 @@ static bool expr_field_str(struct hist_field *field=
, struct seq_buf *s)
>  			seq_buf_printf(s, ".%s", flags_str);
>  	}
> =20
> +	if (field->buckets)
> +		seq_buf_printf(s, "=3D%ld", field->buckets);

[Severity: Low]
Since field->buckets is an unsigned long, could formatting it with %ld
cause it to print as a negative number if the highest bit is set?

If a user configures a histogram trigger specifying a .buckets size that
exceeds the maximum signed long value, it appears the field will incorrectly
print with a negative bucket size (e.g., =3D-9223372036854775808) when the
configuration is read back through tracefs.

Would %lu be more appropriate here?

> +
>  	return !seq_buf_has_overflowed(s);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913203129.9412=
70-1-donggeunyoo.kernel@gmail.com?part=3D1
