Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552662;
	b=3kT5Xld7DlYgWKFuvYYlia/HNqWX6DYcJC5CL6UGNcg3wLlKnZcbJ1xHV8Nd9Elq8OHC
	 WqV4s3tzb3X1NYX1nM+Oyun9iIk7lD5xk5qMtAKpFaqrOVax3YzwG/sm7NX7/twrCHHPT
	 IfKd3yph2cP8OAo2cZ/z7ks/bhRbLQUfOHMVNHtrJESdUTF2Noppjf3GX84uucn5TTfGq
	 PqMXEQlrHjBys4RSm2SEx9P0pZeIi+SVut5dLeGhzldrsMrNX0La7YMpU7aY3iVsmhaL2
	 Ww9b/P/z7KuvSkF5Y0QM5Ko4pVhxojEw6eRIQ6gHElpPGMU+14skowyZwplmCCsNixQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E9VnQKCg1dnous2inWWG9kqifWbv8MXcfZ5+Oz3mKsE=;
	b=FBvNfS2XmX5DkDlZ6nVmeaeChQGjPXMLjmwwF7rZRj7cAHQQq6kglPL30bMAiv+u6sqh
	 CWpbwMu1gqiDsMiuk0gPJ7rLMQarVDMfp5wmnMl0nEschzlx99fKJ8fuc2b3TG2/3MQp2
	 VG5jVe+/v8DWkyvujnt7PAHHIdtyeLBtZTeLircysnR2TN44ff+MBv5Z5Cv75KfJvZrFq
	 +mT03JBWHrKh9vYSvGVcDppZ51fYyhCP9MXUjPme9bz+Blngow2HUoDKg45SAXg5PVtao
	 TZrge6I7ou7hzsHztLs0oZpKT4bmU+/rulXNB0OgSNHVUiR6+025w0tFtMrE1bQB64w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTH1Ys0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A88606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTH1Ys0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBC81F000C4;
	Fri, 13 Nov 2026 06:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552661;
	bh=E9VnQKCg1dnous2inWWG9kqifWbv8MXcfZ5+Oz3mKsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTH1Ys0KaafJDxpTrHpPvCgGYbGxCYmtdjrIVVIrrRvUHSGvPB6+F6PWzViyKrrYv
	 8lWyMT7uW4FdAJx4uRq3ZBNTg4YTM0wJrkK/CcqQhOGVUUttWk9ZUxyUK5WsYoqQDX
	 TB9y+gnUtcq0xw9GaW3RdBLH+/7iK3u0PISeI5lSSi4qVc2aiwN/AfUpNT/ldMmxKt
	 0E4KWZ56lFGChhTk7rDaDHDWMzhj9YiKzaeMzAAHdj83dI0cc+NSKXybxIwyXiEsta
	 kKjZawDSrztfRl6l8yaHus/neySKLwplIndyu5Aac3ebqwTaTwvGuPHT6mnNrdp/oy
	 5S3xOijSne9OA==
Message-ID: <sashiko-outbox-212290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] tracing/osnoise: Start all eligible cpus from
 hotplug workfn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113064103.3041704-4-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
 <20261113064103.3041704-4-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:51:01 +0000
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
- [Low] tracing/osnoise: missing Fixes trailer for
  osnoise_hotplug_workfn() race fix
--

commit 20aa2424de0f956e6a71e5fe659aee66ed386374
Author: Crystal Wood <crwood@redhat.com>

> tracing/osnoise: Start all eligible cpus from hotplug workfn
>
> Previously, a start could be lost if multiple cpus get onlined
> before the workqueue has a chance to run.
>
> Signed-off-by: Crystal Wood <crwood@redhat.com>

[Severity: Low]
This fixes a race in the CPU hotplug workqueue handling where eligible CPUs
can be left without a running kthread if multiple CPUs come online before
osnoise_hotplug_work runs.  Should this include:

  Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113064103.3041=
704-1-crwood@redhat.com?part=3D3
