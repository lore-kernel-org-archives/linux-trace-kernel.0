Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307822615;
	Wed, 25 Dec 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735165715; cv=none; b=ANfV5lerMrTRBdaZuccG/c60mHnt/5wGiyFBamdIeVNKvY0T27I9iQaRagNyZxhFLo9uemgOmqhtW8pkyuztEyxLTk5YpvChacbdvzAFuo0plZHx5yQFZVzAuF0a+qWNiKca/DXXQlbEVg5s/AouZdKwP2XJOoRol6tqgGIRPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735165715; c=relaxed/simple;
	bh=7W3KMQlMh0Xp3Rl3oPzyLp6r3hMybuNffTjtsRGePb8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=jlOtNnIoxgXleQEMz/U1lz/VST7/1hYzRfeZaxtE2vgNt7I7BNpOwtYxaSkC3IiNZJbDiL5zy5RlMdVJFoQ/6fn2eIUfy7PZBts2S/0ELC82lLU5XUn2EWbv5LD/pH3Tf8gNgASvtFPdU6H+8SNuHxm5zOS2EkCd1zET3Rb4Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE28C4CECD;
	Wed, 25 Dec 2024 22:28:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQZsh-0000000FS1m-24Fq;
	Wed, 25 Dec 2024 17:29:31 -0500
Message-ID: <20241225222540.685602520@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Dec 2024 17:25:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/2] tracing: Fix patches with goto out
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

In my patch series:

  https://lore.kernel.org/linux-trace-kernel/20241219201158.193821672@goodmis.org/

Of switching over to the guard logic. I missed a removal of a goto out in
the osnoise, but fixed it in the stack trace patch.

Since the patches are supposed to be agnostic from each other, fix the
osnoise patch, and remove the fix from the stack trace patch.



