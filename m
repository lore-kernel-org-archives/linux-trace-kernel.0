Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2832E6BC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848668; cv=none; b=qG8qJOrydL+GP5rirvXstc2NQM17Ntayz6V34cOUXMqjgy5grfS15wVstHbgiM86dFta67dVg6IuU8fNLbpdQGmhfZ2iN72DlcfM1V2W1w823ilL8UCi1IKnTChdZg834GT2wcMsrjphKFjGQ6p+87UBkrrsbDQoZqHbhCvnXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848668; c=relaxed/simple;
	bh=UFaMlKtu2nqcJi6ZuKOFuvyw/nLc20yhGlw30NxqlF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtzXPkBbpVNvVzrVIRwVsxBCDaHgd0TKnwt0byAI1IJtu4xhCGJ8CO2pxnDx5X+pkyVBMm52r+ImqBEH+hhYtsWqBi2Wmj0QuQAe7mXpCRb2JmUJa7MDgw9LnaFBY6Pb4+xu/QXIC+42qJFUjY/C4oiIgUJzC+YXAXnYQtKXcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSEoqBJj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSEoqBJj"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c801d732058so4959871a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 19:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779848667; x=1780453467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UlhJB/zo1GUfvlC/gFMCB3J1W9IgleTW7pEjex3oK4=;
        b=HSEoqBJjpqdoieWp62S1WtG/QWU6Cyn5i2taNKOJxwQpJvbF6RGkZ74GibJB3x8Nml
         FB0luvjOfE4yiCi330xNrHzDSpk5cB3Jk8JoJmrl84ZbOJPUd385FPl7FTot5m+josrI
         pCClqvYZAF9xT65Gb/LEiHiBlkS5Q99KCWKverjCvz6VZI9uuPMIxX0FaSYEx5ZN6SPo
         TwTPjraTGSP3BYmwY3fjpq/A/xTY6AEEx47Pfc38QXSysgReSg2gQGtZvmcEambIZCjH
         orjwx5BICj5COcnXvXhp98oEIJYrtn+K4qtjzyoyL0Raq9PBp18fqK6nZ2vAj5Ejw3n5
         NSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848667; x=1780453467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3UlhJB/zo1GUfvlC/gFMCB3J1W9IgleTW7pEjex3oK4=;
        b=RJjdzovBEVdBXCXpYSI8is2o3sAEsWVNU/5fHxCD2Jg4GoPK1QCFohY8BtaoedQjSd
         vG+bjn57FY/qlgHGxUcL1Cl/+3RXo/vCaMV2KCDinn8zhVZ/0RcZ39EvOOvZ6xsvtfD3
         oqSv7+pN54OVZlqPhlAD2nC+H7lho7S/zd93+8yvZD4OXVX/TyneR5k+ObbhApJh0GqN
         mOYciQCZ4DPmC17lvQczbg/paFUWRuAZLU3KJtyVpHAeOC2RnGKiRKLKs8nJ+QcHn3i2
         LArq7cNc9zH8j6UybM5PQth+SSUYTIf34XLqs5hqyurA+XR5pc9KnGdbJq+VEj1Lq99a
         iUTw==
X-Forwarded-Encrypted: i=1; AFNElJ+MXOeqKaSnMSCuwegKSzCy63z1Gwcp/VRHzYFMZ5RnDw0ZGsJWOpsuYdUbswYCRi1oVRMg83ZXtvR6Wr5jcFB3bYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUduh0KxfOB2EHumdAos9kpO+44KkE3UZ4JKSlX7i3uF2rSaUe
	zT70lSJav9aoqp71DDKYaRgEoqQwKJm2jTVSj8+kKfO6b9Q6KOSCP39p
X-Gm-Gg: Acq92OGjGfLpl8lKLq5D+8VX+PVyL1jC7bYcD1Dzk3qUux7F/vX1I+1Ytxa9iMPCeep
	D2L/xWn1YRwedCGz23BJEx5KoMbzq46oDG/sHOfTuUMmBt1vX/1+9giKMgdHZ/YgyqBDzXD/UUv
	ij47KXOCuiyPQ1XOb910ktk6QxQVm2dr8UN8Qg36wxCOr2ck/lkcIXgPeqHd85egMEuia6iPHsf
	usIIlnNvcjTaIIgM5trRokdv3zCZqJ5bxzQ8HR7CAq3hhi+Y+NUcIs0AcS5JzdIVZiyisCbrUwC
	TdxLu1mKuMFqnN2eglaHEZEO3xQC41mf7dEMfJXPrpVF/PhTsVcps24wA0CdVsa+kQXd5xl9cJy
	MMZ54o3EhOAXOgYUUXdQ9UlwSbZOgTNJIhUcnROKo1KXM+TgXXqdXA1xe52gfgMOge30XzkzCGW
	JjPvLWCi5ablKskGF5U+qUJbd3d1v0btVXX32RveFvmsSlHA55
X-Received: by 2002:a05:6300:68d4:10b0:3b3:115d:dff8 with SMTP id adf61e73a8af0-3b3115f2275mr12637085637.4.1779848666674;
        Tue, 26 May 2026 19:24:26 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d6ff:7a7e:f223:7f2e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028ff19sm11646329a12.5.2026.05.26.19.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:24:25 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	Pengfei Li <lipengfei28@xiaomi.com>
Subject: Re: [RFC PATCH v3 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Wed, 27 May 2026 10:23:50 +0800
Message-Id: <20260527022350.915843-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153905.093aff7c@gandalf.local.home>
References: <20260526153905.093aff7c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

On Mon, 26 May 2026 15:39:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Please DO NOT SEND new versions of a patch or patch series as a reply to
> the old one. It makes it extremely difficult for maintainers to manage the
> replies and patches.
> 
> A new version should ALWAYS start a new email thread!

Understood. Will start a fresh thread from v4 onwards and use a
lore link to reference the previous version in the cover letter.

Sorry for the noise.

Pengfei
