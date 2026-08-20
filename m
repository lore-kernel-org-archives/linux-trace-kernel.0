Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0347D471
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244782; cv=none; b=j6iMkATDAvvnyK7BQX2/qtuqtbUo9ESdbowRmn0h36iDAmKXC91nvt0YEPFNvszwTbmP/pPT5aoKwzc1gKlWeyBHtWWTYLe2c98laLGhEK5Dw62gJvT8YMBXpg9rPs9dYyS1WIiEjb2a0IoZpTP4GfbHIRvSKLAj+cgaP4W/VT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244782; c=relaxed/simple;
	bh=XvuYZdJYTk3eyno6slqYZMCSysubxOKhw4KQv52NlBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JxZuj22+bW1Q8KPufXC8Rs+tSZbUILrxc12dfv1sSxUElaxdtXAWfZKZhTlnbkKe6Z0bogBPk6D3kFZzOYw6pRMJvOSYy1rMzNZ/imbZlfWp+KQ6Xj/5kMd7Y0x+y62U1CO1TAkcRxo5My4QuJTQOHICENmbx9gSxubFgthiRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY29tVp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY29tVp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C64F1F000E9;
	Thu, 20 Aug 2026 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787244781;
	bh=fDnwkTIaIlvRfxJqqUp00/s1npvOOhopR8rB2Y9HvK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RY29tVp/W7Vke1CCH5v0ys2JdlvHV/QfMYa87tMTW7YHIAQlCz2igMQtphPrqVcvb
	 wGthPkx29humVE41SDDzfKcaaU3OGwmXOAnAxn8Xu90+iPB1QDPEVKoHoL8oGP9Eb7
	 3j03fk9JqqSIwttbuBHZkesJG+n2WTZSvu0SFbWRhXVvbVanuHoZkQ43aAKVdk62vh
	 FNb1fURmZSbidGGyxNI/KGjJPAy2u/0xyIoINPUAf0rD7xonXbtiYuWAvhIXt3bWOX
	 8MvZa0zYbnOAFtAHItooApP1NroiVrnfARePK0NIKeswn25dLInNKORQA2UKVhX4ED
	 6ra80seT2P5/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] rv: Add tlob model DOT file
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <9e27f8af4520800fd1f19a2b9e9c0a0f2250920a.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <9e27f8af4520800fd1f19a2b9e9c0a0f2250920a.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:53:00 +0000
Message-Id: <20260820165301.0C64F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The implemented DOT model contradicts explicit claims made in th=
e commit message regarding states, transitions, and invariants.
--

--- Patch [3]: [PATCH v6 3/9] rv: Add tlob model DOT file ---
commit 8a3ea61817d2834335f8a9230c5ffaf2a08353b7
Author: Wen Yang <wen.yang@linux.dev>

rv: Add tlob model DOT file

This commit adds the Graphviz DOT specification of the tlob hybrid
automaton to the kernel's verification models.

> Add the Graphviz DOT specification of the tlob hybrid automaton to
> tools/verification/models/.  The model has three states (running,
> waiting, sleeping), five transitions (switch_in, preempt, wakeup,
> sleep), and a single clock invariant clk_elapsed < BUDGET_NS() active
> in all states.

[Severity: Medium]
Does this description accurately reflect the implemented model?

The text mentions three states, five transitions, and an invariant active
in all states. However, the included DOT file defines a fourth "stopped"
state, two additional transitions ("stop" and "start"), and omits the
invariant from the "stopped" state:

tools/verification/models/tlob.dot:
	"running"  [label =3D "running\nclk_elapsed < BUDGET_NS()",  color =3D gre=
en3];
	"waiting"  [label =3D "waiting\nclk_elapsed < BUDGET_NS()"];
	"sleeping" [label =3D "sleeping\nclk_elapsed < BUDGET_NS()"];
	"stopped"  [label =3D "stopped"];
	"running"  -> "sleeping" [ label =3D "sleep" ];
	"running"  -> "waiting"  [ label =3D "preempt" ];
	"waiting"  -> "running"  [ label =3D "switch_in" ];
	"sleeping" -> "waiting"  [ label =3D "wakeup" ];
	"running"  -> "stopped"  [ label =3D "stop" ];
	"stopped"  -> "running"  [ label =3D "start;reset(clk_elapsed)" ];

Could the commit message be updated to match the actual automaton
implemented in the code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D3
