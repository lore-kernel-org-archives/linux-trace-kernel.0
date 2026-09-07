Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E22949E0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759074; cv=none; b=e6ZBgNiA/PV1MYAWjs3egUvJbPem7Zqz3qpD9eowtXMneB3PQxsxkTnt248UeGOHL402TYKV3MPLBzj+IvO8+vkWrlFW6H5GYeOpRuQJ8Sm8QOOT0MUSsW5ym4wGJ0tZAVS0b7zSKfjVFhPeZAXSe/T2RDjtOrVvy5MVN62aQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759074; c=relaxed/simple;
	bh=AEZlGEqzntNg6zAj9xRJE2JUA2M0MqXOdfzr7ZaT7kU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFhWJ7iJKjwwv9rroUbhfPJf9zFs1VlpRx1W16pQwjN5njTL3UbjDh6ue4rmogfIi1l0XNRYt78IoM49lSH8FUQa2489XyyGUn5jjlJ7lfrOlGyIZT5f96Z52kzYxQa14k6TVcOAXPWqBfSGf4CTh7ZWSSg0Fyg0GisHllAnejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRosyjy0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRosyjy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED91F00A3A;
	Mon,  7 Sep 2026 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788759073;
	bh=L9tilZ73ePX28KRrLBTBU9s81uNJoBjEa2OygM2FA0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRosyjy0kPzd8OCseL93aJ/WtJ2Iw+JNMOBtQrXnNv42uWjeGTtR4B2Pn/bCuTmrE
	 /uyMhfGcKUKuUn6R0c0qgTuu4BwZW/yqesZD89kYq8eHC2rGODtDfnN4u30ClAmis1
	 BclBzP7gNXrBzm3IxCJMjvX5jQKvLCa94WkG4HRzyd2fyg63PQM0isyslX7FZBUT4C
	 b9QfIgbihRHlVqulApRWJ2b3EIpDh9MGFSx7MbthS7zp+lPF1hHROs/ndGxzJXluTq
	 /uXDVlIgTsH5/gLv1wdeg0jBdgCBCKqVC8TorZhnBvDiiCBJZObTYgsg2z+ktCy+uZ
	 7rYoO1aqRrXoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: hist: let values keep the percent and graph
 modifiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907052113.430818-1-donggeunyoo.kernel@gmail.com>
References: <20260907052113.430818-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:31:12 +0000
Message-Id: <20260907053113.1CED91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds loop and invalid pointer free in tracing_map_des=
troy_sort_entries when stats allocation fails.
--

commit 0ec7f4c23d8ecafd15abb3d5f3ff02ac2abded8a
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
tracing: hist: let values keep the percent and graph modifiers

This commit stops rejecting the .percent and .graph modifiers on histogram
values, fixing a regression introduced in v6.3. It allows these modifiers
to be parsed and printed correctly when triggered.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 893bd8b0e48a8..6cb595cbcdafe 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4313,8 +4313,7 @@ static int __create_val_field(struct hist_trigger_d=
ata *hist_data,
>  			goto err;
>  	} else {
>  		/* Value */
> -		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
> -					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
> +		if (hist_field->flags & (HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
>  					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
>  					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
>  			goto err;

[Severity: Critical]
This is a pre-existing issue, but by allowing these modifiers to pass
through, does this expose an out-of-bounds loop in print_entries()?

If kzalloc_objs() fails when allocating stats for the percent or graph
modifiers, it sets n_entries to -ENOMEM:

kernel/trace/trace_events_hist.c:print_entries() {
    ...
		if (!stats) {
			stats =3D kzalloc_objs(*stats, hist_data->n_vals);
			if (!stats) {
				n_entries =3D -ENOMEM;
				goto out;
			}
		}
    ...
}

It then jumps to the out label where it passes this negative value to
tracing_map_destroy_sort_entries():

out:
	tracing_map_destroy_sort_entries(sort_entries, n_entries);

However, tracing_map_destroy_sort_entries() takes an unsigned int for
n_entries:

kernel/trace/tracing_map.c:tracing_map_destroy_sort_entries() {
void tracing_map_destroy_sort_entries(struct tracing_map_sort_entry **entri=
es,
                                      unsigned int n_entries)
{
	unsigned int i;

	for (i =3D 0; i < n_entries; i++)
		destroy_sort_entry(entries[i]);
    ...
}

Will passing -ENOMEM as n_entries result in a ~4 billion iteration loop
and an out-of-bounds memory access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907052113.4308=
18-1-donggeunyoo.kernel@gmail.com?part=3D1
