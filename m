Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302F450F2
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788702354; cv=none; b=BmVMc95t0Hn3sg4Mty9bNsXA3vGsnh1jfe++ZVFuCGMm/Ywg7Li2IaKGnjtYqqKZB8V0u8QoqtxU7vQBln+anXx99YWzSEIwFhjkJikYj+Bs/WuPMUkh3HLZcdIeiwwrtgqvBc0ufGf8ENRzNWOsSr4oo+EC85luqVSOWQM99Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788702354; c=relaxed/simple;
	bh=aGz5K5a8GaTOVJXq7I4//Bg3XxNxXfL0vrkgco8ofsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kAb0Y02MGXiUT1Ka3iNKWhM3td3ohnMfUdUBsgLkBreaucIBCixbbZZxFTXjgw18Mkc3SHNE1SR8uKR3TBTYwWLkbzcrJ9rg3WcuAj9IyMEpXfnm2YKYHWJrPOmqLiQXjKT12mx7Ptn7+XcsRU6syROe9476fnOKrS6CqmQ6aIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePH2YitP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePH2YitP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E331F00A3A;
	Sun,  6 Sep 2026 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788702353;
	bh=QwwwqYrOmXoDymG1r2Pt+z4UcnONQmW5Zp+3XLj3Tuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePH2YitP7VhAV7jAuUX7rhWRuIp4AQKqboEY7exyNYs4csnPHsHpGglM24NWZ1Jji
	 EVTioAd3WYvrYCDDC+w55vmKxOErXPMuVInytVMHrcUasW67jeE7KJC+khTu5RRkN4
	 5IciI1t1VGzQvUPTOtuB9pmhwNbO6iwmtMmDGbLJx2IkgqHRn7D6JJGfJ8CP95wdl9
	 CT8UxudBDG3r0BUDsvP76dpyevf5Bv3U8DQl2u0SpjLVwjAijq1aFQbrhIb69hytYI
	 DH/7TdPTVNITKGgpchIO9anf4Oo0lw7/f3kXtvWuvwxmGJpL7Q6iPkPtnf0ZDCTinX
	 UWYome0hqh3Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: hist: free the var ref when its initialization
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260906133352.3815019-1-donggeunyoo.kernel@gmail.com>
References: <20260906133352.3815019-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 13:45:53 +0000
Message-Id: <20260906134553.71E331F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak in `__destroy_hist_field()` for variable =
references (`VAR_REF` fields) reused three or more times within a histogram=
 trigger.
--

commit e42abc814ef3aa510a981868dbef3bcabc30250f
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: free the var ref when its initialization fails

This commit fixes a memory leak in create_var_ref() when init_var_ref()
fails. It modifies the error path to call __destroy_hist_field() directly,
ensuring the VAR_REF hist_field is freed without checking flags.

Link: https://lore.kernel.org/linux-trace-kernel/20260906124025.3550596-1-d=
onggeunyoo.kernel@gmail.com/

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..34831a01bb9b5 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2234,7 +2234,7 @@ static struct hist_field *create_var_ref(struct his=
t_trigger_data *hist_data,
>  	ref_field =3D create_hist_field(var_field->hist_data, NULL, flags, NULL=
);
>  	if (ref_field) {
>  		if (init_var_ref(ref_field, var_field, system, event_name)) {
> -			destroy_hist_field(ref_field, 0);
> +			__destroy_hist_field(ref_field);

[Severity: High]
This isn't a bug introduced by this patch, but does the reference counting
logic for VAR_REF fields lead to a permanent memory leak when a variable
is referenced three or more times?

When a tracefs user creates a histogram trigger where a variable is
referenced multiple times (for example:
delta=3Dcommon_timestamp-$start,delta2=3Dcommon_timestamp-$start,
delta3=3Dcommon_timestamp-$start), create_var_ref() increments the reference
count for each reuse:

kernel/trace/trace_events_hist.c:create_var_ref() {
    ...
    for (i =3D 0; i < hist_data->n_var_refs; i++) {
        ref_field =3D hist_data->var_refs[i];
        if (ref_field->var.idx =3D=3D var_field->var.idx &&
            ref_field->var.hist_data =3D=3D var_field->hist_data) {
            get_hist_field(ref_field);
            return ref_field;
        }
    }
    ...
}

During normal trigger destruction, destroy_hist_fields() visits each unique
variable reference in the var_refs[] array exactly once:

kernel/trace/trace_events_hist.c:destroy_hist_fields() {
    ...
    for (i =3D 0; i < hist_data->n_var_refs; i++) {
        ...
        __destroy_hist_field(hist_data->var_refs[i]);
    }
    ...
}

Since destroy_hist_fields() only calls __destroy_hist_field() once per
unique var_ref regardless of how many times it was referenced, the
reference count is only decremented by one. If the initial count was 3
or more, the decrement check in __destroy_hist_field() evaluates to
true and returns early without freeing the struct hist_field memory:

kernel/trace/trace_events_hist.c:__destroy_hist_field() {
    if (--hist_field->ref > 1)
        return;
    ...
    kfree(hist_field);
}

Could this allow a user with tracefs access to repeatedly create and destroy
such triggers, leading to memory exhaustion?

>  			return NULL;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906133352.3815=
019-1-donggeunyoo.kernel@gmail.com?part=3D1
