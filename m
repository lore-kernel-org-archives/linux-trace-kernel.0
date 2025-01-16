Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367BCA4E;
	Thu, 16 Jan 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990437; cv=none; b=lGYVNueEEmeVJn3aCREy+2iO3+xxLHcuS5STSLPHvMizFMmqZz8ANetGNoNodboafFFkEmREdTW4JfRjYl1BlpOAsdpVs1C/fMOtpJtec47MlxsuTfYyyRvvUcvGo2Il7dVakdAjdks3ri64fhhDdBX3A90ecfYbmLrATPyiRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990437; c=relaxed/simple;
	bh=DxLMZwA1OdOm9k1gO9zreHb0LK91Eg4FIWLgQ2I7hKs=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qmMFhigQBlBJe8e0xE7uRPlj8UA5BoR57mScV8ouXpVLPCxtXoP5F9dvHXEevsrpJq8ryxoKP0+mUYkX92k3TUMVvkia9j/2VBh1o4nO/KtX4B9saFviOqw4B6cRVp5v0XG50GU5JnLex3unhkkF4faBiXXPcmKtMz1Rnyko/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C18C4CED1;
	Thu, 16 Jan 2025 01:20:36 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYEYr-00000000hbV-116x;
	Wed, 15 Jan 2025 20:20:41 -0500
Message-ID: <20250116012009.840870709@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 15 Jan 2025 20:20:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] selftest/tracing: Allow README requirements to be tested for instance tests
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Allow some more tests to run in instances. There's a few tests that
require something in README to be present to run. But currently README
can't be used for instance tests. Fix that and then allow 4 more tests
to run in instances.

Steven Rostedt (3):
      selftests/tracing: Test only toplevel README file not the instances
      selftests/ftrace: Clean up triggers after setting them
      selftests/tracing: Allow some more tests to run in instances

----
 tools/testing/selftests/ftrace/test.d/functions                   | 8 +++++++-
 .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc       | 1 +
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc    | 3 +++
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc    | 3 +++
 .../selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc   | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)
