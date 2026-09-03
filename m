Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A33FE35A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419726; cv=none; b=TbgWhL1QwQyg9aLjTe03prdIoHAfZmqZ5AyM4GR+GQyxoFkvAQyWdlw4egjarZGFfP4L/x4WKUGLH1pc0+R/R8NEdh4Xs/vx7epJyqOccjqoVUmMuIsU+rt4nAUo888XBtP0qN990Q0hVDO8Csxjpkpo+52YNsrA+5XzKRJUevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419726; c=relaxed/simple;
	bh=oFBS6Acf3DIfp1QcsySu3fteHOLnb1ld42822S6Hbf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cnpd8cZZ42pNwikqtJGTUFSZZ7ZH0V87HGXjgOG5HjFTZAVsqJAniRtg8azzJJ4wxjVRObgREsKZ9H9gD0p1r7MRtMH2Z9WX0cpPfhxr7UxTcrqKAzlKMZM6e4odo3DdLnCafbchocOlTILMZOmWft3LoneVjGrO5cgl0lKdc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn236bmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn236bmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5121F00A3A;
	Thu,  3 Sep 2026 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788419720;
	bh=oyz2zrvVIrF0LQlbY1/9UfoIHBVbtBhHfvVohZ/d9Ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fn236bmAmA91KpcfaZaf8ddm7yj7Y0dBPbEWiBOIJ5LDGJl+kkrOwWogDLsrCyN/Z
	 21/oW5T0SCZ1EubU9M0T9dRjh2XxprIIgkKt7/ZjySp087cReRPT2jpHB/nmPam2H5
	 1N+3SSyAM7sR350lqm3idbUDFE6flmgWHUQn+x8fZo9dG6jwxp5ijocENw+gk/I0lV
	 SJn1DyUj6xXgbJdfMUHN3u7XbhcrjvC5Lr8oLCcgUFTi+j+ihf98oe3c8qFCRgOe3h
	 wR1kDHOFa8VSqHcoPyBHdkU3riuyiPhBpdW4RiBh5BvSAOBtxs/7jeJTQFDon30CTp
	 GoKQ70dHkLN6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Documentation: trace: histogram-design: fix bracket,
 improve wording
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903070249.713483-2-manuelebnerli@mailbox.org>
References: <20260903070249.713483-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:15:20 +0000
Message-Id: <20260903071520.BA5121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch fails to implement the missing parenthesis fix claimed=
 in the commit message.
- [Low] An unrelated line of documentation was accidentally deleted, breaki=
ng a sentence structure.
--

commit 708a883b89775bdba5b9179959e1d7aeeadf6600
Author: Manuel Ebner <manuelebnerli@mailbox.org>

Documentation: trace: histogram-design: fix bracket, improve wording

This commit aims to add a missing parenthesis and include a note about the
new way of triggering an event in the histogram-design documentation.

> ---
> @ Steven, I added this line, because else the references wouldn't make se=
nse.
> References: $wakeup_lat, next_pid
>=20
> + ... (which
> +could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
>  are implemented, the parameters specified to the trace handler must be
>  variables.  In this case, $wakeup_lat is obviously a variable, but
>  next_pid isn't, since it's just naming a field in the sched_switch
> ---

[Severity: Medium]
It looks like the intended fix for the missing parenthesis was accidentally
placed between the `---` separators in the commit message. As a result, this
hunk is treated as commentary by git and dropped during patch application,
so the parenthesis fix is missing from the actual file. Should this hunk be
moved into the diff proper?

> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/tra=
ce/histogram-design.rst
> index 41a726cd35369..86c83b177e446 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -25,7 +25,7 @@ tracing_map.c.
> =20
>  If the kernel is compiled with CONFIG_HIST_TRIGGERS_DEBUG set, an
>  event file named 'hist_debug' will appear in each event's
> -subdirectory.  This file can be read at any time and will display some
> +

[Severity: Low]
Was this deletion intentional? It appears an unrelated line of documentation
was accidentally removed here, breaking the sentence structure of the
paragraph.

>  of the hist trigger internals described in this document. Specific
>  examples and output will be described in test cases below.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903070249.7134=
83-2-manuelebnerli@mailbox.org?part=3D1
