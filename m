Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6627AC2E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911986; cv=none; b=ASGM4uX9u8F9gBwUv24Eg8YJGxloLV6GlHYUSb7j/3IrwFWcJIuQkAVLicz4fR9U5pawY7AwHCZbK15Ei62pQp0Ge4QOVHPiCfQEpEcc2K5WQ8fPkfujpcp3vbk0dyq8eZzcfvp9rMJrLEZRipMBkiOGvBSzrV+eRWf7QWi9+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911986; c=relaxed/simple;
	bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eceKrdP7bRb0DH7qGZWpuYwsg8/d2KIUEh7TzreXpdBZT1BgyBgcwgBDx2wBd8BdxxUtniue4n2oR7CX81Sv/vRlL9+LVW4WQWiQ2x96nQxgG/wSilp4kfd2YP1Tfkasiuv+pXplyBfMHLw4NJqGQZjYiA6FjlUoWeRWUw7z3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTQTafqI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTQTafqI"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso61126066b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762911983; x=1763516783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
        b=gTQTafqILKv2gJJzkyGCJM1V/VPVQlGUnAszGi9hAEV0f6tHBtWdR7tCX4il2WyVkX
         iyvOQVMFAIdDfs6M2P/GTh3jmlPWO4BY1ENTeAV3ecBy1cPtDpcNJTccF1O03j6i4erB
         m4MFglA0wVgS3RgIfGllW+UkysU2nKE3LsZbd1SBjMcD4OMHhaz15QcAj4rxOkoY30j1
         4rEt/CesFcuMvUk7y6LRz+UBFK6wicEIJSj5InH6gDF7jC+PPgzlJ8sLh6CKs1lQPw1t
         7SlEIyJgK/ZwnFkHtZZu5AnQjCnRwn0i27X+M8a5KMxCGB6l4VzHOggsBTnzY5jSRK3j
         8FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762911983; x=1763516783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOwvu5DNwJ2UjVrFWBX4/403boipijZrPqaD3H2tIZw=;
        b=X5TQxrGuMQtgLMRArXYtUzmlFw0jZsqri+feyv66F7scZsT3fsXG6tDMJrVKOY5vTo
         FwHU7E7LwwIXm1UiONd/whplulWeoxdfFfaTdnoUgMhdZHebH//jChSPUjTjBCYe7Q07
         lvnNqwmMue48HUeFo0svzKv0PMf9BRG8ydxOIgQDnniNQTVBpBj6OpD6qiB/+o6bPZCp
         96CEgPJYKdrMNDJH1aikl61ciq+OYtK51z+y4U/pfEym5Yzf1xi/fSwcNavd0a4Tvab8
         sNEcXYJ/TUGCvyIjePJR94dV24mBjg46ShSJD1jA4/wGLFXQUslPWbGY2jw432KBkqYK
         sBwQ==
X-Gm-Message-State: AOJu0YyBXnTfCv8e67ZYgbyPPqHGYxw+O6cmKnEoVtOXC4JJrthb1aLW
	7dApmU617UpH0fFTqAp1felQmhz0UqU02usVq9FRz1NWNoi2iRbj5/VGSHK0bQGWGlF5pV45qeY
	Zn4nMuwPDjcS+7FZRfmCF7P3NMEarJeE=
X-Gm-Gg: ASbGncu6JN+5nLC/w4dKJgF/U6gfPprk7MG+73FVOWMetsmdfrBPaUSikRpdPpEeaiM
	Va26Oj53wFAb1bKoBTIgx3B71oJbc6OQ6TJBquSx1RZfH9ktbcigUFpsYdiPom1s/27YWYPtiOa
	H65G+CpGXUBADZUkYZY6CLi8x/qqVz3vRMhellVotGi4iu2ubBU1Jjke5PavtuQyUCfr1sKYdWe
	7vmIw3Czliji39FUAMUZ/Gchwtmm6UGFLeLGsj3frlWQ/2+0hU0mtU5Ve3N0y8r+9u0Pd4/
X-Google-Smtp-Source: AGHT+IFf9VeeFncXYo3f4CCqReWeYkEYLxn0BvQvtjwZM2iKjZyMB5M2tztDvxrxzrMOijaP0r714s5CkmVrJgZ+mDs=
X-Received: by 2002:a17:907:9727:b0:b72:de4f:cea6 with SMTP id
 a640c23a62f3a-b7331aa95bcmr118977866b.48.1762911982618; Tue, 11 Nov 2025
 17:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111135432.2143993-1-dolinux.peng@gmail.com> <20251111182820.4b44cc8e@gandalf.local.home>
In-Reply-To: <20251111182820.4b44cc8e@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 09:46:11 +0800
X-Gm-Features: AWmQ_bmgZcr4beak1JLM5eV-k5OGp54yWXF1Gvxb13oBy5WlTpQJLVMkVldYrAo
Message-ID: <CAErzpmt=pgTh_MqxFvnnZt8HOgs_g3nFNjPWuXv0Sy0S69xPsA@mail.gmail.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Nov 2025 21:54:32 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> BTW, are you two people?
>
> You only need one signed-off-by. Which one do you want to keep?

Thanks for catching this. I'll fix it in v3 by keeping only one
Signed-off-by - I'll use my Xiaomi email since this is work-related.

Apologies for the oversight.

>
> -- Steve
