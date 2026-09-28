Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C54E3222;
	Mon, 28 Sep 2026 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616330; cv=none; b=axwEiiyN86mNz5S96JFAEU1ymtmtL++AHZrt2VpIceehzRxMl9ylf8RTAu2+JpkUrtY4zC20/ZtNSDf9JyQtx1X2sa4h+vM0ubF2+ObSMshZ3cga13xNEINAFv8uqxN+fABasE7S+f7lFo/lhuBCPlf9IGFidDcbRBTZgxgLDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616330; c=relaxed/simple;
	bh=t7ciOat8NBAE1wVSqTyG74L/2dyyeqvgmvIccluNMoo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=h37FWNynmgf31XZkI3gjwvwJyiHuQnmwOZvqv3O7xdbb+rgJagLCgt35EOlbZgQqze/+O8FnRpenbjKMi4Jgh/MFigYrXad1+WEljcXMnm0glID9vOIojE5V1d/QVk/TVq37LO6qwZxCB6I/7v+eCTiMpm5JUvClq69opHEGboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=A5+Cnyft; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=zm602OBl; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="A5+Cnyft";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="zm602OBl"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616300; bh=k126SaJbWbPm3yQDF1Bzvdo
	RS2fDCbZch92XD1cDkQM=; b=A5+CnyftyhiIVzTrVI/LfoIQuZ4iyLIbPbzW5HLlg+3CeUf9ES
	Wwwkx/sMv6qdfoyYjhguDmh+rtyxRkPBw/jo3VGJU3p1+zJvg9+Q62IliUEwpkfXPBvZow01IP8
	Szj2CrJl2WQD2wuBIP4I0oEln+rcU57WhsEZdjbVCEawXxpcxSGaGVPPw+gKkz3xc2xEViEqUUl
	Ue20Ih9Je2mZF1MqtrQ/l2e4u1P+mXVQvMU0L8WdYjIb68FykwPRphqeOscRs+vuRHrFgZy1EC+
	y4ZpQ67mjXpIVM6K2kXeSSn6NM0Coe2Z5p5CDgcedW4fkEj6nNjn0g4wm6IL1gN55yQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790616300; bh=k126SaJbWbPm3yQDF1Bzvdo
	RS2fDCbZch92XD1cDkQM=; b=zm602OBlU9S4vhyB9DWLQZnbUJZTaAHoy+ZYEh1EPWUhxVdHK4
	+GySt+/tmodn0A2ILZ/wvBzCYXdUDISKOsBw==;
Date: Mon, 28 Sep 2026 18:25:01 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_docs=3A_admin-guide=3A_Handle_TAINT?=
 =?US-ASCII?Q?=5FFORCED=5FBIND_when_parsing_/proc/sys/kernel/tainted?=
In-Reply-To: <bf400c123ec86a7192388ad23cfe4194f536937e.1790612298.git.u.kleine-koenig@baylibre.com>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com> <bf400c123ec86a7192388ad23cfe4194f536937e.1790612298.git.u.kleine-koenig@baylibre.com>
Message-ID: <6551F533-E1C1-411E-8EA1-140641E1B84D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 September 2026 17:46:02 BST, "Uwe Kleine-König"
<u.kleine-koenig@baylibre.com> wrote:
>tainted-kernels.rst contains a small script to check which taint bits
>are set in /proc/sys/kernel/tainted. Add one more loop iteration to also
>handle the newly added TAINT_FORCED_BIND bit.
>
>Also simplify by starting the loop at 0 and save substracting 1 for each
>usage of the loop counter.
>
>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>Tested-by: Randy Dunlap <rdunlap@infradead.org>
>Fixes: fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when userspace manually messes with devices and drivers")
>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>---
> Documentation/admin-guide/tainted-kernels.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
>index abbf5e3dd749..a208811ad525 100644
>--- a/Documentation/admin-guide/tainted-kernels.rst
>+++ b/Documentation/admin-guide/tainted-kernels.rst
>@@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
> script, but if you need something quick you can use this shell command to
> check
> which bits are set::
> 
>-	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
>+	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>$i&1));done
> 
> Table for decoding tainted state
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
Reviewed-by: Bradley Morgan <brads@mainlining.org>

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10

--- Thanks!
"I'm not a very positive person" - Linus torvalds
