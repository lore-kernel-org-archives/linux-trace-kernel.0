Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D71A314F;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432588; cv=none; b=CVYDywcp37nLYWo7uIlT6FQfu0iFAzPT5hwp3b1ypvK8gwuRmqV1aDEqH0wlzAGuJHvB/Rl5291+vx+Ie5yD4/wMIDaPd+59O29mx7jwiYC9y3hNIJAxE0fvGyiV7Es+8gS1oaouY5WZfBLX4SrPVH/Jy0m88geGqSKbJQzZh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432588; c=relaxed/simple;
	bh=Gahg1PmzzwlLvzybwAuPqY03/QNPU52zxWkz+uzIwY8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Qa7HEWjeMJL8yYPH5erV3HEfVZbHrnk49f7Nt17OMBG1Z1pDJ+GbsDq+H+yIW6C0EWbJ7MwOeU9EHyBK7m144oaTL0YoyQs0Hlcxl0MmtsLuIq3z5OIxk69obHauRJ8u0bIoKD4w5akaBhDYUD/tFlvVpiHabg08AIfHXl+o1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGSSFFhu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGSSFFhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8DAC4CEF4;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756432588;
	bh=Gahg1PmzzwlLvzybwAuPqY03/QNPU52zxWkz+uzIwY8=;
	h=Date:From:To:Cc:Subject:From;
	b=QGSSFFhupvR6s1Vg550bodKFYpJbZvAMa0Nrc0AF+SN5vkTf90w9JhVbJIfvDxcey
	 Uz5QKmIdeFUGgU8uPlhcxBwsrtBbqrLpRu6BapW8E0jvdM2NjW8+aP1xfCzNU+5bMr
	 I1e83dUf2khblwTSQV+R62KMgPekSx7d3c68+2PcSTg3MZ6YcNJmjWZyaK6y06kDXn
	 or7RBEZHtdHGh4vx8018EuYOJOyp7/clIsoZWYYNkL7zsMt2JiZ+D/Nxj7dwWSJzGP
	 8Hnlt6wPRYIVQL2jPKZ+frFH0nu6OW3VIeTK3hJSp+hIUHBkJmnVEFlqzXPPYWUePC
	 /sQRVUyv6IUqQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uroMD-00000004Pq7-3amI;
	Thu, 28 Aug 2025 21:56:49 -0400
Message-ID: <20250829015552.314865014@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 21:55:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] cdns: Remove unused tracepoints
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Tracepoints take up around 5K per tracepoint. This is regardless if they are
used or not. Soon unused tracepoints will cause warnings.

The cdns subsystem has several unused tracepoints. Remove them.

Steven Rostedt (3):
      cdns2: Remove unused tracepoints
      cdns3: Remove unused tracepoints
      cdnsp: Remove unused tracepoints

----
 drivers/usb/cdns3/cdns3-trace.h            | 61 --------------------------
 drivers/usb/cdns3/cdnsp-trace.h            | 25 -----------
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 69 ------------------------------
 3 files changed, 155 deletions(-)
