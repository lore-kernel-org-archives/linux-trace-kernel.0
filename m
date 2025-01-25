Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DB1E98EA
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Jan 2025 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768460; cv=none; b=g7vqi+SLoRTuxOiBmNfNxUABfdege6xnC3O8B+WagBh93OErBxhCO5Esk66N1/knXvONqbBW9HAQtLtOAWjuM8vLBHj3q9wm7gxqvwj0gaNB5M5BEZjLSS04suAWD+rd166YYWPfVOR1X9yFbH3uwTtw54xP/T1ot4F6yI4Stkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768460; c=relaxed/simple;
	bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MHQpWPQyjYV+wZyjYjg1ZczFBHDTUC3ol7AtXzETMnZG7qTgGHKVe0iIDl+DpCi4vtX4elXi5f6SUXLupb/ohz2wHHRGNCQpHPbpbkVNWS3xy6CN6lYeDWntLpg5NgPgRbJysAjhTHL6micE1Y8pXxeWnwc07s6mrWDwX/iCcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rlm99Qu0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rlm99Qu0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-218ad674181so77597165ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jan 2025 17:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737768458; x=1738373258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
        b=Rlm99Qu0NNz9ldED5l2yEfhMrklqZPRwQifUxdAJop1243rmyl5Wyi+MPObUVTE36T
         h7QwpFyD1JsZXtHTJGkZhBGZX++pw4oGv/PGatIueku58S6ZeucxWfT6PYLLOvhhPHN/
         lhgHp4LDDp0KEPW3vSNYf22lRivcwt4WD1tQQtnK6Q5dZ8Ua9/pYSLbUkE60TT1tctDe
         giWDU8ALxgcodFtZhosZR+gG94EJjp6pvTXhT7IenRzXYdiQuH26SwE+nmafsHV5solq
         HuZVO5iE7Xbkys9uPEq4+klnLRPi0Zi7KryckzDbfc9FIKoJHpGSK9vGF2MQybpkVNVE
         76fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768458; x=1738373258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfidSHmbxgOnB9/75Z0Mfl6TO6ZTxDdFedFPlmzMN1A=;
        b=SNcbMM/fULLTUZVec3zF9fgqGRYOU2nL2M2M1skbMJXIO7j6Akn0l62947urJ5FEP9
         V5OB1RicNKacVO+jTAc3PqvvyPdsSNq+mHcFRV/DAqRq/cl8OsbW5bF5botTuaAI4o4R
         T2jqeMHSnFVl1yYDdjFQDjxdkpMYAKmuqleMVIwoVbsipiP+k+tutw+10tPh6bs0XS4b
         deM6+zaNmXgwWXl+cGbQ31nxzdw93r1FVX+sEFpsUmramqbfD+rsTgpeLlyqhnWRtD7i
         qnvTSkcQ+wdMyGLlMnZZo55U+0+Y1jebFX9YB6NbqV0uSHFjnNwAqsuW7DS4iQQm0wC9
         MF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVp+nVuBQURGqUBSuoMQ+5whI+5BiScLiczh26xaQY1j3/h1QlxqwKJE7YuIeSO+RYBf602Cg+8xic14fqgQ3MMKvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFEoiE3t9IBmRUJrvWJRpRZiSvcXW/6Bah1STrmyXsb3aWvqo
	uD1SiPDZQS/3aQZzXPprf6IdMUXppmVotubXFoFmNTx/C4ih8EcN6FGyeQws+3FG74Lkhw==
X-Google-Smtp-Source: AGHT+IELBMc7dMnIqFdjDchTOfCLu+kjz8nw9HTDOcVfnUFyGQfVruXBkW3NA4nAGJnNa/aL6nW3ApS2
X-Received: from plfz10.prod.google.com ([2002:a17:902:d54a:b0:21c:2d63:f756])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:181:b0:216:4122:ab3a
 with SMTP id d9443c01a7336-21da4a11b82mr89219405ad.1.1737768457927; Fri, 24
 Jan 2025 17:27:37 -0800 (PST)
Date: Sat, 25 Jan 2025 09:27:34 +0800
In-Reply-To: <20250124152824.292985bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250124152824.292985bf@gandalf.local.home>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250125012734.1661860-1-keyz@google.com>
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> As for if it should be applied, that's for the maintainers of the subsystem
> that it exists in.

Thank you so much!
