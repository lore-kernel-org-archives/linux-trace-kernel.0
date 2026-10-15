Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2E53E0B;
	Thu, 15 Oct 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069837; cv=none; b=KixgDJoCnF0TiuPfhAvGNe3RclKw4HMncLWpgzmNtAMIhU0NZqWhTZDWZnCjW28+qnNq8lV4T0e5Qbu7+X5F99N0iOOwU0FT27h2RWjNRjrH4mrHCa3jMa/dHahqXe0ls/vkOxREEcvHldJ81Szta8i3Z5BkAU4PosjJpVi06tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069837; c=relaxed/simple;
	bh=sz4hzEZJLPdSVWQJ5xfTfuuVT3yRhnpOVKvUu1szxHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=teg9uk4bO+qWkyEQT4Iqtubr1FSibqe4mTHubtLNfzVKem6tJtUt9EBSk7yMxgEfOvrD5FlNdfZH37EroEMPXJDl9LVTEWqfnSZqF7ZTLWwUKC47IUMGObsGhGqSPxkVHq9da7yCQcOKv2Fr0PEbvA0I0MJ4B8zHaEojZSmpuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSgNKyB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSgNKyB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52E1F000C4;
	Thu, 15 Oct 2026 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069836;
	bh=SQFo5wC07ThRu0a3yHnNYmLfM6ZYz/KtYif9hkram5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSgNKyB6EpoRDOEK8z036qCP/tiQSqx+4QRnnSXT0QiGb9X6/m1ph2n8bdnx6M0ry
	 KYywAriuDYE785XEva20qbcUQvTxELqpYVBpsZ8eMn4Nx/PUfxhnPDdDzQaCZym1Ro
	 JOBi+Waom34zkhppl1bGlBwYXhzw7l+pPzyIks2OF99o+BvkQf0pHhqPJlKfQR178H
	 Zkx7KPSGtLBq374Ln/fSDm0S6J2BfX6idfuZXCV9XdDE7c7r1YvH+nbtP5jM8+1roU
	 n8lB7xdVCdPRxmjAvcw46tKyeuu90naP+x6t3xQ65Q5YvYGis1zwWuI+U+hFes0+8d
	 su+sZXpQM4i/g==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nam Cao <namcao@linutronix.de>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5 0/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Thu, 15 Oct 2026 22:10:32 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261014094415.374-1-yuanxiaofeng@eswincomputing.com>
References: 20260828091202.1124-1-yuanxiaofeng@eswincomputing.com
 <20261014094415.374-1-yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015131034.7F52E1F000C4@smtp.kernel.org>

On Wed, 14 Oct 2026 17:44:13 +0800, Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> wrote:
> A breakpoint trap taken in the middle of an LR/SC sequence clears the
> load reservation, so an SC following the probed instruction always fails
> and the enclosing retry loop re-enters the breakpoint, livelocking the
> CPU.  This series makes the RISC-V kprobes implementation reject probes
> placed on an LR/SC instruction or between them, following arm64's
> approach for its equivalent exclusive load/store instructions.
>

Please do NOT reply new version against the previous thread.
It is not easy to find a new version in the message list.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
