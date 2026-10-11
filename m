Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81035A395
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748431; cv=none; b=HqKd0e5cf87oh/vu9sUR7LHqsGVuiQS/Zylh4wp0U04kQ897F3YECe4GiRsa8jno02zXeEAreKqVB/AV7ihaHUwn0nicXCnIUkl/kPVf60MyJeUOuuE08WDVYDk4rR8zPO11sbp31VryGEXqDt6zMnwImtzW8/Tha4rzWSMDbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748431; c=relaxed/simple;
	bh=hR6fkr+G7ozhUs1W9jG2uzvn8dPAfvPpz+lAvj734CU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VxHqW0IxIj3ZWs3Vh4CnKAV6Ib/JNpHD7X3fObebQqnOInqZXVhUf9/uALGJxyw9sF9Cee4yAWG3ZsCXvg2uCUPmhI6MsVnBN5yvcFAYOwVa6S2egf9Txhlf6OyF3Ez5+jlxIqj+u+MrRQ9X7YDncbH0t9ImdQBTHMiql0jf9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex6EFbpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex6EFbpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394141F0089B;
	Sun, 11 Oct 2026 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748430;
	bh=3vCL6FGGgK0+DHK7FSrgEkxYg/Jc2pCK8YLiP8nZfKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ex6EFbpH7Ht2pvyIGlutdtN1r42qBbxh9Hi+REDRa8/DD7rjfMxdosMNFKQC/iHso
	 A69YToy3eJ+1A4FZ3vgdfykRytS5BTpKzYGKNNgKwU9gDRtdLGiNYlcSAYoR5THo5T
	 b9pqnh2UKZNvLhzVYE1HWBWbIJHlYD1JdWYw+WtXlsUDPSMuBHkqYWSMGPXtghCYwV
	 L43TJ3tN6ZdmXnHpEJ4q7NfGfe3Sj+D2tVXvSzfplT0XLQ3dAZJ21RGNUhPC9gkgoN
	 ZhSem70ncrYYdReS+sgoWwrKfnlulw9cONSALZj5EfSbH8eMNFD2EYoUJsflrEDm89
	 mEzKtSSHO2Zog==
Message-ID: <sashiko-outbox-167427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] rv: Make da_monitor_reset_hook and
 EVENT_NONE_LBL overridable
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <d8990a03af61a6989b9db1150b1205873b83a5c7.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <d8990a03af61a6989b9db1150b1205873b83a5c7.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:53:49 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rv: undocumented API change making da_monitor_sync_hook overrida=
ble
--

commit 4c23c506287e928a0c126474d4bfba46c2216f6b
Author: Wen Yang <wen.yang@linux.dev>

rv: Make da_monitor_reset_hook and EVENT_NONE_LBL overridable

This commit adds #ifndef guards around da_monitor_reset_hook and
EVENT_NONE_LBL in ha_monitor.h. This allows HA-based monitors to override
these definitions with their own implementations before including the heade=
r,
such as cancelling per-task hrtimers on teardown.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 99b60d0d26b6d..b8c74d4d40649 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -38,8 +38,14 @@ static bool ha_monitor_handle_constraint(struct da_mon=
itor *da_mon,
>  					 da_id_type id);
>  #define da_monitor_event_hook ha_monitor_handle_constraint
>  #define da_monitor_init_hook ha_monitor_init_env
> +
> +/* Overrides must still call ha_monitor_reset_env() or cancel the timer.=
 */
> +#ifndef da_monitor_reset_hook
>  #define da_monitor_reset_hook ha_monitor_reset_env
> +#endif
> +#ifndef da_monitor_sync_hook
>  #define da_monitor_sync_hook() synchronize_rcu()
> +#endif

[Severity: Medium]
The commit message explicitly claims to "Make da_monitor_reset_hook and
EVENT_NONE_LBL overridable" and mentions wrapping "both definitions".

However, this change also wraps a third macro, da_monitor_sync_hook,
making it overridable as well.

Was this third API change intentional? If so, could the commit message be
updated to mention it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D6
