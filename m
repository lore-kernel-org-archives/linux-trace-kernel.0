Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06134EF15
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509229; cv=pass; b=LRqY+urw0Slej+hfDigRRh3XokQf98yZYAgAeIKgc93y20YrVuLmuSkbX2tYLlbTm0NeRJIf3nJdK8GLsu/KvZFCP9j8B3Yd3Zs8SmySOP0NXD6bOSYuwxf8jXgbYY69IIDi0bFLTDmaPpHjl4lRyzGtMUcXZ/rhv0xqEeylsXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509229; c=relaxed/simple;
	bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzM+zgX+RqyZSz5ubCugVr47Zt6j+5HcNNWAM9MxI9UizDftwuBG9vBcWoV/rxKG4pcmU5m1mvshV47GyoknauH6+lgHZkoRhBDGFGWrCQ1JaK/MEqz8NdyruOLadAPm/Mxaf+G4Mwz2rciC4GwJJAa829Mpo7fj4mp8px6SLbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaMcgFKE; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaMcgFKE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so1031294a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 00:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774509226; cv=none;
        d=google.com; s=arc-20240605;
        b=B9+kw1PWOIxDY2Ym6ikpnQl2+78/K5b1Qne27UYy5LkPlwmr1obtogS1XgCjIWUikE
         mf+OaoJwmFon+Z7r+qTvuVDeueaD9THKWtdwQE0Jb6vQEz7dOtnwflMMJhb9f9+h16pT
         L0Pf62oMPBSybMCo7hCgq/RfU4k4QL/T8iSg3LGjhe0mctrB+WjdXVmLDUnzU3gqwNnI
         R5mFY0+ptlCkirYiqW5aSd5OwSRjPda/LR15Z5AQdUtMlJ+/jaHwnBCgoGyx63BYzw0j
         fssS7DKs4+STzlUu6X1tFThMJ/uzkP4mY83gcJoaN/e+kJYG6+eXy4cejVQGJF6Cwex5
         vNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        fh=Dk4xDUkHRRDCgQBrVRdXLJ4YsMhZkTZ2EAfZV0OcETo=;
        b=WGjk1qu6Wl80l1u+eahqtR6eisnBHEQ5Qc+Qs3H1h6Wm/VrVY5gky7z4YIT1BhRtxp
         5IGy4VIkI8qRny8fz71pLvAoDTMsVC44H3Uh+aVj97ycrLRhnxfQHSqPkyCrXuCjDRr1
         depmqDN8rvyyC1J1hPNB/KZNZxHcVYH7Bow3pjH4hEQd/fw3/Y0/Z8DivPX0ekRpfh1d
         3E9YBKG1QiGQA7hkUSri8hpIPx63NYpkO6oUqg5/PqUPSaCeKzlyam45Yp6hDo184FFQ
         26jcURF+nABc4d58yl8bFLF9f+kjCZLOSMseqSDDqBYmd4CKBhcsceCD3VthB0sjY7Ai
         +sMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509226; x=1775114026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        b=DaMcgFKEQzwzVn+3dRyxTXKcyFW7z30x2q4rTZ7DbPyAugOhW/hNCJfC/X/RC4m+qR
         qT7JYCFLdmrPHAcqaEClNtfz4zCNCafSsTx7kVaqU8NJGnFq51SmFzJqRIKAdoBPZNWd
         gUNVkACr8KWXewOfFgVaGLKDWNh5JQhSLFtuhPhPXENFa7oc8p9XvYRKJTjV5hQwVxwh
         jqPWpzXPvbsluzNjwluQ3YaalOyxWZFlkU2ii3hH9T8M6s3ihDQ465b+v8eQgYws2UnT
         yonjt8cQvnlecQd3ZaSxO71XqUaLs21lT2gIjNPWxXCf41KB8ID1w2oi53fI9GyatG8R
         ZQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509226; x=1775114026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVYIfY5RGVU5hE9Bo7jlxGQ00nzCfo4JVtwvFNTkonk=;
        b=p9Vwef8IN5XYcLdGY5QgE+jwkQcoOALQhPsgM0pSaOkPg2rV4PPOLrPv3DHrl2ESCN
         n1bUK30Or3NKEDMecPvBy7GJI/Yvt5fNEqFXoEM2CSa3cV4fcJPv3WF+FLZOI0NCqn+/
         5dVP6tK4uDmfbvULfgweRUtQtppYwp3uvNE8XvdSmqGJ6kw6CY9OdNl3yBG4gZJdJhgC
         OFH/+USRb4aHvQo4KXq/3oJtNyuxzdcryLqWpq/PQi7Dkkjv4egVt1w2fKB215ctz1un
         HN0YGTsOvs2Nb0KXij3es8p2PaxajzlziHASC1e4YTd+MTQCYINMpdiXDvDKR3vFoFjy
         UxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnbfiZaC36h1eZqcG5PpKLy1hJgPv9yFyz69Obr8aO0PoZ68Db6XMUYHANWTphQ/T7JrVUTwoefyAurtJ/K54FY9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYkCkFOVL6lYborPpb221Z6t60JzkC/UjOdkgpw6ainCCWQdP
	1yv7qA5P8rMkurX1pjnX4t/VJgSJU9ic0JpX6YZxAREFdaDx9/xAyKlxFhCyzYYXGIRtchg2FTF
	+LmX6SxVQxoekqryLXG4kQvbrfOpp0Ak=
X-Gm-Gg: ATEYQzzHF5bMKVte/OCHHUe4DYrwEBVMNHdjt6ZE0tC2iWbhtaJDSue06IW4wBoVccl
	MU0Tz/gQyz4k4ndsxhxKIRu3Jd/amw5Uu0c8xLjvYtCylDuGrzX5Yw8XT/4dsuqDHMkllS5Fp0b
	F0Z85G5ILisk2vs/qvWMACW6iykEGONhGnVWVuJFA3Q87aDfgq04yJSeJTmKHPXJNMet5/oA9R2
	lqJ43JVLt0KbiL0G+zUuw76iaKI7e+EtWUYT0ZmoqHYtor9AU58ELHD/oQ0y66gZY//9LSERLj6
	kf05Eg==
X-Received: by 2002:a05:6402:35c7:b0:663:56c4:2dc9 with SMTP id
 4fb4d7f45d1cf-66a826a164amr4266656a12.16.1774509225926; Thu, 26 Mar 2026
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com> <1774403912-210670-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774403912-210670-4-git-send-email-shawn.lin@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Mar 2026 12:43:29 +0530
X-Gm-Features: AQROBzDOhjtwDHUqjyR7aLHKrElwwWK5j8GxED5sK_-NhNXgE0WUA3wwNc4lR-Q
Message-ID: <CANAwSgSwKt04OYX4ckkMu+iRm2D8BFp9FpjRWUh=5ad77dErqw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

On Wed, 25 Mar 2026 at 07:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
> LTSSM history. Any LTSSM change will be recorded. It's useful
> for debug purpose, for example link failure, etc.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
