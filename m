Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178245;
	b=5BZpK/iaFFxgtPK5fMnyvJ2VOjYQqHa7Xgj59we4j3JCedleI5XUr6LIi/ZQs9hkdER+
	 6yOFX1B3urJ+OBnJkBmEQGoHOtpwJ5T2yx/LFuz/MOGCtgo+WJMucKO6xwKuwqqpjfohx
	 7FpwFAacb/dtZ1nWsjKsqjZ01kQdtgEMrTWdWyoyoOGiIIprwr/j/VI0kr1dOZmLiKtK/
	 KZw5uU3diP29LHX9Npl2qkoWL/BTt9v8FdxmJCYRBnIG9LXylPNR7B03dAMDHPTbN35pz
	 x32umicKae7CzoUdI6/DTJpZNXAGB7b8fdcAGvsxy/V/Jpqf5yrdM5x/gqVzdrSAeDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bs247TMy5ZVgaAryWhBMwTNU+j8yz4KTRR2MUfwT5Xs=;
	b=UjHIVAIJxcBLyWFXkVJubOyaCLH4hqMLxvKPAmJWVfpTo+/pVhoZ98RPbwGc22kpDYHf
	 PWpxbhT5Ur4pyPYI4IOvN4EFS3VuV+0+Ur5rigFv6CLeiqmwe1wymxocP5AsS5pf1KuYf
	 Nd1+W+ftqtjL2heZL0e4TtyX7yZ9zbD2it7FM486zd6pdq1HyktM1p1aAn7GKA97a3H2U
	 TMHT0AKpnfr3SbErtYsY4MMf7bUK+HpcC0lAl0zS2ycY49m0LuPHqyEAdzXl9FfkbytnW
	 yMn2MV1mcRy+1Z+OVA7eBDneG4L+Re1vgCLzOYbnGbarUvERaw3GdoHrUHLiFYGPY+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7yk6Qiy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E12606A330
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7yk6Qiy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92A01F000EB;
	Fri, 20 Nov 2026 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178245;
	bh=Bs247TMy5ZVgaAryWhBMwTNU+j8yz4KTRR2MUfwT5Xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7yk6Qiy5gV7hoevafsG9yUGOWyjFnVaynp6tkIDN/c9ohX+f4nWh3ldMHhcfXulW
	 9B87VyuWpN1ZlVDVU+xidOc2yH/CM020llKi2cb0WRkOHvsLgkWrSnnVvggzgWL5t6
	 JbGWaW6wbcSQTJOZ0gSNbS2WjMtedZplmcvgyG88hxjEYpL+qWBxRzQe7b2SBe6D9R
	 f3AJ0f7nTHRQ7ttWE3Riu7339j7SWScdMrEeHjkLJdRPWrnJZ13L2Fu72kCXIwpf8g
	 CXWy0ZuEfFT1jY8gimfRMT8PKSIlmPbxKGYC1YZd73nQCNqD647ElTzhVCAZgtLqaj
	 /YfeECltZKlaw==
Message-ID: <sashiko-outbox-225150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Restore custom event creation selector
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261120122837.1597798-2-thnkslprpt@gmail.com>
References: <20261120122837.1597798-2-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:37:24 +0000
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
- [Medium] tracing: duplicate str__custom__trace_system_name on second
  custom header
--

commit e451694c0169b91ce25bbac13cc9b1321c4dd71b
Author: Avi Weiss <thnkslprpt@gmail.com>

tracing: Restore custom event creation selector

This commit restores CREATE_CUSTOM_TRACE_EVENTS instead of
CREATE_CUSTOM_TRACE_POINTS at the end of include/trace/define_custom_trace.h
so subsequent custom event headers in the same translation unit are not
skipped.

> diff --git a/include/trace/define_custom_trace.h b/include/trace/define_c=
ustom_trace.h
> index 5827a4c92c744..177c628f2d567 100644
> --- a/include/trace/define_custom_trace.h
> +++ b/include/trace/define_custom_trace.h
> @@ -72,6 +72,6 @@
>  #endif
> =20
>  /* We may be processing more files */
> -#define CREATE_CUSTOM_TRACE_POINTS
> +#define CREATE_CUSTOM_TRACE_EVENTS
> =20
> -#endif /* CREATE_CUSTOM_TRACE_POINTS */
> +#endif /* CREATE_CUSTOM_TRACE_EVENTS */

[Severity: Medium]
Does including a second custom event header under CREATE_CUSTOM_TRACE_EVENTS
now fail to compile with a redefinition of str__custom__trace_system_name?

Each inclusion of include/trace/define_custom_trace.h includes
include/trace/trace_custom_events.h, which sets TRACE_SYSTEM to custom and
includes include/trace/stages/init.h:

include/trace/trace_custom_events.h:
#undef TRACE_SYSTEM
#define TRACE_SYSTEM custom

#ifndef TRACE_SYSTEM_VAR
#define TRACE_SYSTEM_VAR TRACE_SYSTEM
#endif

/* The init stage creates the system string and enum mappings */

#include "stages/init.h"

include/trace/stages/init.h then invokes TRACE_MAKE_SYSTEM_STR() to emit
static const char str__custom__trace_system_name[] =3D "custom"; on every
pass, because all custom event headers share the custom TRACE_SYSTEM and
the definition is not guarded against multiple inclusions in the same
translation unit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120122837.1597=
798-2-thnkslprpt@gmail.com?part=3D1
