Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559C3932E6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788699032; cv=none; b=qGxm9WwtUXYVvw8aWt5GLeKJcJfSKrwqngo1SUfHIy/eMxvM93Lr59lJ9FofI9hXVGsGDzJ2Rlh9OQW7k+NZhlB4O+o581HItwRgbx+nxyTxGTMAkLF/y3wEa/sI8iBWPZLyDrULIvDlYOnfGuPnjemzoTrh2KqZcwA3kwwvs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788699032; c=relaxed/simple;
	bh=gdRTty0nP5mOXs1M2+UtZtUyqZRWwDnif3mXKWhgfMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nh4yh/mrNIAsmkYg7uRrG27en+urOp2XGBNS4ag7+9oMceXqQ99sZMHTCSlb5Nl7OINR4D67siTX302e40yEZbM0Yk+q0M1m1e0PAgMPE3wQMI/+mjSj4wZcPMGt9FZXpemQ/RDbwzVCa9x327R3HITcXAURmsrpjSkAH+LEwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXbimRd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXbimRd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711111F00A3A;
	Sun,  6 Sep 2026 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788699025;
	bh=tOqguBt/vuKURD1zRFX2wjtqLZwrRRflggAokxgi0f4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oXbimRd/ZAW8yzuVE03gtWVFHXTob6UX2GFfc8pM8IbMoWuCpj1lbNAIuEzUWODst
	 dgLuocHgmjHyTf+yx+UrC/J1w6qgTcfYuhyfZJWOkUXkGY1yQfzSg6KNDzNRBHx8e4
	 GwiVBj1TvKLLLEKQqX7wDX5Fh88+fXV6BA5ZUpR8QTgrGoSq1Dtoh2RUqIuQGUy2zC
	 if082v0wx6mJLqhAbQdOr5SCY93FFLA/thCPNHoSE+Z55r+A5D6g6aAjtBTIqfBvTD
	 W9xramN5IsVfv/ItOPde0i3l+AE5rteIYR+57RY4fagFeXOqLwVmtQj6iFzaPpYHlY
	 NaoMuRBPJt5Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: hist: free var refs regardless of how often
 they are referenced
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260906124025.3550596-1-donggeunyoo.kernel@gmail.com>
References: <20260906124025.3550596-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 12:50:24 +0000
Message-Id: <20260906125025.711111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of a newly created `VAR_REF` hist_field when `init_v=
ar_ref()` fails in `create_var_ref()`.
--

commit 7e5deb418198a666953cde5c792cb003b22199c2
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: free var refs regardless of how often they are referenced

This commit addresses a memory leak that occurs when the same variable is
referenced three or more times in a single hist trigger. It fixes this by
dropping the reference count and unconditionally freeing the object when the
trigger is removed.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..f90680b33a373 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
[ ... ]
> @@ -2223,10 +2212,8 @@ static struct hist_field *create_var_ref(struct hi=
st_trigger_data *hist_data,
>  	for (i =3D 0; i < hist_data->n_var_refs; i++) {
>  		ref_field =3D hist_data->var_refs[i];
>  		if (ref_field->var.idx =3D=3D var_field->var.idx &&
> -		    ref_field->var.hist_data =3D=3D var_field->hist_data) {
> -			get_hist_field(ref_field);
> +		    ref_field->var.hist_data =3D=3D var_field->hist_data)
>  			return ref_field;
> -		}
>  	}
>  	/* Sanity check to avoid out-of-bound write on 'hist_data->var_refs' */
>  	if (hist_data->n_var_refs >=3D TRACING_MAP_VARS_MAX)

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at
create_var_ref() in kernel/trace/trace_events_hist.c, does this code leak
a newly created hist_field when init_var_ref() fails?

The function create_var_ref() allocates ref_field with
HIST_FIELD_FL_VAR_REF set. If init_var_ref() fails, the error path calls
destroy_hist_field():

		if (init_var_ref(ref_field, var_field, system, event_name)) {
			destroy_hist_field(ref_field, 0);
			return NULL;
		}

However, destroy_hist_field() has an early return for fields with
HIST_FIELD_FL_VAR_REF set, expecting them to be cleaned up via
hist_data->var_refs[]:

	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
		return; /* var refs will be destroyed separately */

Since ref_field has not yet been added to the hist_data->var_refs[]
array at this point, it is bypassed by destroy_hist_field() and never
freed, leading to a memory leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906124025.3550=
596-1-donggeunyoo.kernel@gmail.com?part=3D1
