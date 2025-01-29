Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118691A2399
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jan 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140668; cv=none; b=VgQGSfVnRc+QDaUwMYOoiSk4YpEvN2eOaDbpO7/XEKhvm0ykB+hVErrZLfkRKhmmzEe132HElCP2f6eGKD4bmYnxX9zhuIAIJQ/lTxT3Tw9ddRViWI2gKxQFdye8JJfFavgxGdi/0RkVGr73+X9MlP7iGnH2zXmuyKmTeUfhp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140668; c=relaxed/simple;
	bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQ3ace572WkU7+KPLHCH+iKqeCXAf+KBVCOTgMUg2vZq8lIB/obJi9R3mR9YPIkXNxDnoEcNJ99rWOjDzYSUyZKDe1rVm4hALsfbI/tUDJOnBTQ50eTYjwHD4BRG7qt0Jv1HyU0Fc9ysw2ho1ELF5iywpw9Hug3+mL0W4EP2ZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4b42LYYs; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4b42LYYs"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2a3c59f8c1cso4419283fac.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jan 2025 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738140666; x=1738745466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
        b=4b42LYYsEVMfzv+2DTojEFqbIeRiRxQCi6GRmIkehbtUqlvh7In/5BH1wCXnvdPARz
         sXmZG3cpAUXEUjeBLMZE03u1gJKmJ/3ZJi1l7vK4xky8aYxTc0WT4vAWdRbM6lmO8Q2i
         INP1lSebLwIKm1v/W1rxhRJEGD05TZPota5cW4kB8LVgriKEbKxjtL0czYnBxEG7YPl3
         0CwPKKWXgbq4BtWorh4HQKkQxgOmdDND3Mb6wf9RJT+lndG3j+QPaiF9SQN/6wgQW0n3
         vh7I+g7Ky+J8DMJGGSar2PNe64ivT8ap7boymI1hXpuDBBQsSnOSaOQ8PNFeDsDuO31s
         XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738140666; x=1738745466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbK8CG3zwHwysZnvAo3A2+mZ2myHIVEiysKYTIFeDEM=;
        b=Fu2x2aDPjTmH55LgtnGvhDqLrgNVgP15EWYL2t3lcUDHVJD8McnNmbn7N+7AqcZLo3
         TNyCwCaOArWo48Z30ZwJlb/EpuCT6D11AV1VjO63Pw/szMDoELfKz3dba522Edq4EZP6
         wYe9wFJaEiW7wMn98PsdcEkvVKxYU7IBt/MkmqpYshnk2drrQIDqWFwpTvr4W+Se+/yV
         wMwFR1ZDKxHGikRbWbkZ1bPEBjSRf517XKLipO8E5dAbfU7pNf+Lcv0eb2S3Mo0VBr4f
         tCj3SDGQECQ2QPiBkZqHcl5N7Z5TG4fBx1mtAxuX7KnxW13bFhgDgYX/7zVSU4/sU9pS
         eE0w==
X-Forwarded-Encrypted: i=1; AJvYcCWXXSvrDnTF7vJo+IkdTudPyh4xgAyDBP+FF6nU6FP9lXK95niaU5lnNjfBsw7iFcY1TavUcucKMsyy7K+t/O0jFyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjanrBeBk79+4aMz2Pi3y9mUbkxWpo4r42vFo2WaN4CnJVxQ2
	3aGHpF9DzJqr3GHDiYJ31K8QJfflsc3cBtW+ECpr2N2sI0oGBTkTW1o1GNjylkQJh/n6Qg==
X-Google-Smtp-Source: AGHT+IFYeVGRIDbBJSoDxW1qLEQa6txtsI65vSSYVM7r1a1CEXTC692rDv36eVRGCThjx3Uetdze5Vm2
X-Received: from oabpp13.prod.google.com ([2002:a05:6870:9d0d:b0:297:19ee:9d16])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:5cc:b0:2a7:d345:c0bb
 with SMTP id 586e51a60fabf-2b32f261922mr1412517fac.27.1738140666051; Wed, 29
 Jan 2025 00:51:06 -0800 (PST)
Date: Wed, 29 Jan 2025 16:51:02 +0800
In-Reply-To: <f697970e-3796-41cb-9904-d61cbedec428@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f697970e-3796-41cb-9904-d61cbedec428@arm.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129085102.1055165-1-keyz@google.com>
Subject: Re: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: christian.loehle@arm.com
Cc: aarontian@google.com, daniel.lezcano@linaro.org, keyz@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lpieralisi@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rafael@kernel.org, 
	rostedt@goodmis.org, sudeep.holla@arm.com, yimingtseng@google.com
Content-Type: text/plain; charset="UTF-8"

> > Yes, psci_domain_idle_(enter|exit) are not meant to replace cpu_idle nor a
> > variant of it. It's new and different events that provide finer=grained info.

> I mentioned it because it means it doesn't benefit from cpu_idle tooling
> directly, which is slightly odd, but fine with me.

I might not fully understand your comments.
Do you mean that even mentioning cpu_idle in the commit message does not feel
right to you, or utilizing cpu_idle by exposing the determined state instead of
adding new trace events is the right direction?
