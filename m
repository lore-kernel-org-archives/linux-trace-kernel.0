Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5668501F3B;
	Mon, 28 Sep 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632296; cv=none; b=j0ns4fzifpocbQt3oPQF5UlLdMpx8qTK4NUTjA7ymyGstX+2kU2149imPnem22GnR2jM6VW4DyVsK7xz1jW2cPWsYgjRyaTEZXNpoiemSqdrJutOdRs1+EhM5zYj/TsA3ePD07ZlA+maAchgOUgax8Vrb56bLW7zEut0tXIvFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632296; c=relaxed/simple;
	bh=cltQ3OeNXyCGMiN3lC8iewTr/syvIiA9urcENLAJnOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDov+BsQaKXACQpPSuD7bC5xhUps5aKRdaL+dFhUlOnHTkHkBvbbfyFI0AB8Bauff8peTDLjqcdibll7maWgtY+3asdU+9hZRLJOG1yQnnbUhKuh3aRSCRGAsXrKljINujD7EQhVmV5mW8RWVwrvku76/iBo2tx5ATYUqIZy2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6JFpidr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6JFpidr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647471F000FF;
	Mon, 28 Sep 2026 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632292;
	bh=3KdtAslMH0gjWUcPEY4j0XYPZrY0UbgAmeW5yqpCliQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6JFpidr2/iArqdYOOYHOQYJqcbJkmIuhoP5LOqKrM+izk4P3zhv017+eLlz+EetD
	 hn/2HL5marmBWBLbUZ0N34ORzWywfBkd5x5MePnfq2ynGFgicMh62AGaIk0d9ZnVIR
	 FgqRP6kh8uTF3VrBxvH3+ewiSwutraU1dTUirGnw0W2adxoPLpSQhtQcpC0J/0NcJK
	 668AVyWyguo9lpbQoL+qmqdKeCVxE0Ops2EgLN9RiPRtNRAknITbC8TI/B+fqAb2zz
	 P7m4BQlRNNKQMhyQS/PP+qMgLYOm6TsFMTpYfiN+guUSMGm1kBj/FxfTzFoyL/FlKj
	 cGf4xFBRZcK3w==
From: Danilo Krummrich <dakr@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Date: Mon, 28 Sep 2026 23:51:27 +0200
Message-ID: <20260928215127.1811259-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 18:46:01 +0200, Uwe Kleine-König wrote:
> [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/3] docs: admin-guide: Handle TAINT_FORCED_BIND when parsing /proc/sys/kernel/tainted
      commit: f1850e443b0e

      [ Fix a typo in the commit message. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
